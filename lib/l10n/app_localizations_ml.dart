// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malayalam (`ml`).
class AppLocalizationsMl extends AppLocalizations {
  AppLocalizationsMl([String locale = 'ml']) : super(locale);

  @override
  String get helloMessage => 'സുഖമാണോ?';

  @override
  String get toolMindfulness => 'പരിപൂർണ്ണ ശ്രദ്ധ';

  @override
  String get toolLanguages => 'ഭാഷകൾ';

  @override
  String get journalTitle => 'Journal';

  @override
  String journalErrorMessage(Object error) {
    return 'Error: $error';
  }

  @override
  String get journalNoEntriesMessage => 'No journal entries yet.';

  @override
  String get journalListeningHint => 'Listening...';

  @override
  String get journalWriteHint => 'Write or speak your thoughts...';
}
