import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meera/constants/app_theme.dart';

class MainContentScreen extends StatefulWidget {
  const MainContentScreen({super.key});

  @override
  State<MainContentScreen> createState() => _MainContentScreenState();
}

class _MainContentScreenState extends State<MainContentScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            ScaleTransition(
              scale: _scaleAnimation,
              child: Image.asset(
                'assets/images/meera.png',
                height: MediaQuery.of(context).size.height * 0.35,
              ),
            ),
            const Spacer(flex: 3),
            Text(
              'Hi, How are you?',
              style: GoogleFonts.lexend(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: AppTheme.textColor,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}