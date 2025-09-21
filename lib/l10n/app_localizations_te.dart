// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class AppLocalizationsTe extends AppLocalizations {
  AppLocalizationsTe([String locale = 'te']) : super(locale);

  @override
  String get helloMessage => 'మీరు ఎలా ఉన్నారు?';

  @override
  String get toolMindfulness => 'మెలుకువ';

  @override
  String get toolLanguages => 'భాషలు';

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
