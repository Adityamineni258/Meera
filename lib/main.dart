import 'package:flutter/material.dart';
import 'package:meera/constants/app_theme.dart';
import 'package:meera/widgets/phone_frame.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

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
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('hi', ''),
        Locale('bn', ''),
        Locale('kn', ''),
        Locale('ml', ''),
        Locale('mr', ''),
        Locale('ta', ''),
        Locale('te', ''),
      ],
      home: const PhoneFrame(),
    );
  }
}
