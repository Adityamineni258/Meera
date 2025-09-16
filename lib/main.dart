import 'package:flutter/material.dart';
import 'package:meera/constants/app_theme.dart';
import 'package:meera/widgets/phone_frame.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const PhoneFrame(),
    );
  }
}