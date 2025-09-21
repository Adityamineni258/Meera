// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kannada (`kn`).
class AppLocalizationsKn extends AppLocalizations {
  AppLocalizationsKn([String locale = 'kn']) : super(locale);

  @override
  String get helloMessage => 'ನೀವು ಚೆನ್ನಾಗಿದ್ದೀರಾ?';

  @override
  String get toolMindfulness => 'ಸಾವಧಾನತೆ';

  @override
  String get toolLanguages => 'ಭಾಷೆಗಳು';

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
