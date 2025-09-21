// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get helloMessage => 'তুমি কেমন আছো?';

  @override
  String get toolMindfulness => 'মননশীলতা';

  @override
  String get toolLanguages => 'ভাষাসমূহ';

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
