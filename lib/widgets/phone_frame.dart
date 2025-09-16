import 'package:flutter/material.dart';
import 'package:meera/constants/app_theme.dart';
import 'package:meera/features/shell/home_screen.dart';

class PhoneFrame extends StatelessWidget {
  const PhoneFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: const HomeScreen(),
          ),
        ),
      ),
    );
  }
}