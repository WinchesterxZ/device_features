import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioRecorderScreen extends StatefulWidget {
  const AudioRecorderScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AudioRecorderScreenState();
}

class _AudioRecorderScreenState extends State<AudioRecorderScreen> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isRecording = false;
  bool _isRecorded = false;
  bool _isPlaying = false;
  String? _filePath;
  String _recordingStatus = '';

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    await Permission.microphone.request();
    await _recorder.openRecorder();
  }

  Future<void> _startRecording() async {
    Directory tempDir = await getTemporaryDirectory();
    _filePath = '${tempDir.path}/recorded_audio.aac';

    await _recorder.startRecorder(toFile: _filePath!);
    setState(() {
      _isRecording = true;
      _recordingStatus = 'Recording in progress...';
    });
  }

  Future<void> _stopRecording() async {
    await _recorder.stopRecorder();
    setState(() {
      _isRecording = false;
      _isRecorded = true;
      _recordingStatus = 'Recording saved successfully!';
    });
    _showSaveConfirmation();
  }

  void _showSaveConfirmation() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Recording saved at: $_filePath'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _playAudio() async {
    if (_filePath != null) {
      setState(() => _isPlaying = true);

      await _audioPlayer.play(DeviceFileSource(_filePath!));

      // Listen for playback completion
      _audioPlayer.onPlayerComplete.listen((_) {
        setState(() => _isPlaying = false);
      });
    }
  }

  Future<void> _stopPlaying() async {
    await _audioPlayer.stop();
    setState(() => _isPlaying = false);
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Audio Recorder"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Status Text
            if (_recordingStatus.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _recordingStatus,
                  style: TextStyle(
                    color: _isRecording ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            // Record Button
            ElevatedButton.icon(
              onPressed: _isPlaying
                  ? null
                  : (_isRecording ? _stopRecording : _startRecording),
              icon: Icon(_isRecording ? Icons.stop : Icons.mic),
              label: Text(_isRecording ? "Stop Recording" : "Record Audio"),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isRecording ? Colors.red : Colors.blue,
              ),
            ),

            // Play/Stop Button
            if (_isRecorded)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton.icon(
                  onPressed: _isRecording
                      ? null
                      : (_isPlaying ? _stopPlaying : _playAudio),
                  icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
                  label: Text(_isPlaying ? "Stop Playing" : "Play Audio"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
