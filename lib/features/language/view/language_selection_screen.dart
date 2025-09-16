import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meera/constants/app_theme.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String _selectedLanguage = 'English';

  final List<String> _languages = [
    'Bengali (বাংলা)',
    'English',
    'Hindi (हिंदी)',
    'Kannada (ಕನ್ನಡ)',
    'Malayalam (മലയാളം)',
    'Marathi (मराठी)',
    'Tamil (தமிழ்)',
    'Telugu (తెలుగు)',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.scaffoldBackgroundColor,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        itemCount: _languages.length,
        itemBuilder: (context, index) {
          final language = _languages[index];
          final isSelected = _selectedLanguage == language;

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
                        color: AppTheme.primaryColor.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 8,
                      ),
                    ]
                  : [],
            ),
            child: ListTile(
              title: Text(
                language,
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
                  _selectedLanguage = language;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
