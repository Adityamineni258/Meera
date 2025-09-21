// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloMessage => 'Hi, How are you?';

  @override
  String get toolMindfulness => 'Mindfulness';

  @override
  String get toolLanguages => 'Languages';

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
