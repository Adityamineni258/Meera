import 'package:flutter/material.dart';
import 'package:meera/constants/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'package:meera/locale_provider.dart';
import 'package:meera/features/mood_tracking/mood_screen.dart'; // Added MoodScreen import
// import 'package:firebase_core/firebase_core.dart';
// import 'package:meera/firebase_options.dart'; // You might need to generate this file later

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  // //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: LocaleProvider.instance,
      builder: (context, locale, child) {
        return MaterialApp(
          locale: locale,
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
          home: const MoodScreen(),
        );
      },
    );
  }
}
