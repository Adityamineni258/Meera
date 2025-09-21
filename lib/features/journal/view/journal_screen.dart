import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meera/constants/app_theme.dart';
import 'package:meera/features/journal/service/local_journal_service.dart';
import 'package:meera/features/journal/widgets/rewind_card.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  JournalScreenState createState() => JournalScreenState();
}

class JournalScreenState extends State<JournalScreen> {
  final LocalJournalService _journalService = LocalJournalService();
  late Future<List<JournalEntry>> _journalEntriesFuture;
  final TextEditingController _journalTextController = TextEditingController();
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;

  @override
  void initState() {
    super.initState();
    _initJournal();
    _initSpeech();
  }

  Future<void> _initJournal() async {
    final entries = await _journalService.getJournalEntries();
    if (entries.isEmpty) {
      await _journalService.addDummyEntries();
    }
    setState(() {
      _journalEntriesFuture = _journalService.getJournalEntries();
    });
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    if (_speechEnabled) {
      _journalTextController.clear(); // Clear text field before listening
      await _speechToText.listen(
        onResult: _onSpeechResult,
        listenFor: const Duration(minutes: 1), // Listen for up to 1 minute
        pauseFor: const Duration(seconds: 3), // Pause if no speech for 3 seconds
        localeId: 'en_US', // Specify locale
      );
      setState(() {}); // No need to set _isListening here
    }
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {}); // No need to set _isListening here
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _journalTextController.text = result.recognizedWords;
    });
  }

  Future<void> _saveJournalEntry() async {
    final text = _journalTextController.text.trim();
    if (text.isEmpty) return;

    final newEntry = JournalEntry(
      transcript: text,
      timestamp: DateTime.now(),
      audioUrl: null, // No audio for text input
    );

    await _journalService.saveJournalEntry(newEntry);
    _journalTextController.clear();
    setState(() {
      _journalEntriesFuture = _journalService.getJournalEntries(); // Refresh list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Journal',
                style: GoogleFonts.lexend(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textColor,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<JournalEntry>>(
                future: _journalEntriesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No journal entries yet.'));
                  } else {
                    final entries = snapshot.data!;
                    return ListView.builder(
                      itemCount: entries.length,
                      itemBuilder: (context, index) {
                        final entry = entries[index];
                        return RewindCard(
                          audioUrl: entry.audioUrl ?? '', // Provide empty string if null
                          transcript: entry.transcript,
                          date: entry.timestamp,
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _journalTextController,
                      decoration: InputDecoration(
                        hintText: _speechToText.isListening
                            ? 'Listening...'
                            : 'Write or speak your thoughts...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: AppTheme.cardColor,
                      ),
                      maxLines: null, // Allow multiple lines
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  FloatingActionButton(
                    onPressed: _speechToText.isListening ? _stopListening : _startListening,
                    backgroundColor: AppTheme.primaryColor,
                    child: Icon(
                      _speechToText.isListening ? Icons.mic_off : Icons.mic,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  FloatingActionButton(
                    onPressed: _saveJournalEntry,
                    backgroundColor: AppTheme.accentColor,
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
