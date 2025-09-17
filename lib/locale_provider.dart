import 'package:flutter/material.dart';

class LocaleProvider extends ValueNotifier<Locale> {
  LocaleProvider() : super(const Locale('en'));

  static final LocaleProvider instance = LocaleProvider();

  void setLocale(String languageCode) {
    value = Locale(languageCode);
    notifyListeners();
  }
}
