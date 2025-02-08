import 'package:flutter/material.dart';
import 'package:device_fatures/device_model.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: DeviceModel());
  }
}
