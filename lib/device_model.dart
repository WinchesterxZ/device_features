import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io' show Platform;

class DeviceModel extends StatefulWidget {
  const DeviceModel({super.key});

  @override
  State<DeviceModel> createState() => _DeviceModelState();
}

class _DeviceModelState extends State<DeviceModel> {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String _deviceInfo = 'Loading...';

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
  }

  Future<void> _getDeviceInfo() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        setState(() {
          _deviceInfo = '''
Device: ${androidInfo.model}
Manufacturer: ${androidInfo.manufacturer}
OS: Android ${androidInfo.version.release}
SDK: ${androidInfo.version.sdkInt}
Brand: ${androidInfo.brand}''';
        });
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        setState(() {
          _deviceInfo = '''
Device: ${iosInfo.model}
OS: iOS ${iosInfo.systemVersion}
Name: ${iosInfo.name}
System Name: ${iosInfo.systemName}''';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _deviceInfo = '''
Error getting device info
Details: ${e.toString()}
Note: If you're using an emulator, some device information might be limited.''';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Information'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.phone_android,
                  size: 48,
                  color: Colors.blue,
                ),
                const SizedBox(height: 16),
                Text(
                  _deviceInfo,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
