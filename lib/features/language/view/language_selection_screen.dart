import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meera/constants/app_theme.dart';
import '../../../locale_provider.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String _selectedLanguage = 'en';

  final Map<String, String> _languages = {
    'bn': 'Bengali (বাংলা)',
    'en': 'English',
    'hi': 'Hindi (हिंदी)',
    'kn': 'Kannada (ಕನ್ನಡ)',
    'ml': 'Malayalam (മലയാളം)',
    'mr': 'Marathi (मराठी)',
    'ta': 'Tamil (தமிழ்)',
    'te': 'Telugu (తెలుగు)',
  };

  @override
  void initState() {
    super.initState();
    _selectedLanguage = LocaleProvider.instance.value.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.scaffoldBackgroundColor,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        itemCount: _languages.length,
        itemBuilder: (context, index) {
          final languageCode = _languages.keys.elementAt(index);
          final languageName = _languages.values.elementAt(index);
          final isSelected = _selectedLanguage == languageCode;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: isSelected ? AppTheme.cardColor : Colors.transparent,
              borderRadius: BorderRadius.circular(25),
              border: isSelected
                  ? Border.all(color: AppTheme.primaryColor, width: 2)
                  : null,
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppTheme.primaryColor.withAlpha((255 * 0.2).round()),
                        spreadRadius: 2,
                        blurRadius: 8,
                      ),
                    ]
                  : [],
            ),
            child: ListTile(
              title: Text(
                languageName,
                style: GoogleFonts.lexend(
                  fontSize: 20,
                  fontWeight:
                      isSelected ? FontWeight.w500 : FontWeight.w400,
                  color: AppTheme.textColor,
                ),
              ),
              trailing: isSelected
                  ? const Icon(
                      Icons.check_circle,
                      color: AppTheme.primaryColor,
                    )
                  : null,
              onTap: () {
                setState(() {
                  _selectedLanguage = languageCode;
                  LocaleProvider.instance.setLocale(languageCode);
                });
              },
            ),
          );
        },
      ),
    );
  }
}
