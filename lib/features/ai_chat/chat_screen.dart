import 'package:flutter/material.dart';
import 'package:meera/constants/app_theme.dart';
import 'package:meera/features/journal/service/journal_service.dart'; // Our Gemini service
import 'package:speech_to_text/speech_to_text.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final JournalService _journalService = JournalService(); // Our Gemini service
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: (result) {
      setState(() {
        _messageController.text = result.recognizedWords;
      });
    });
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'message': text});
      _messageController.clear();
      _isLoading = true;
    });

    try {
      final response = await _journalService.getResponse(text);
      setState(() {
        _messages.add({'sender': 'ai', 'message': response});
      });
    } catch (e) {
      setState(() {
        _messages.add({'sender': 'ai', 'message': 'Error: Could not get a response.'});
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _saveJournalEntry() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      // Assuming JournalService has a method to save a direct entry
      // This might need adjustment based on actual JournalService implementation
      _journalService.saveJournalEntry(text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Journal entry saved!')),
      );
      _messageController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nothing to save to journal.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('AI Chat'),
        backgroundColor: AppTheme.cardColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true, // Show latest messages at the bottom
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index]; // Reverse order
                return Align(
                  alignment: message['sender'] == 'user'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: message['sender'] == 'user'
                          ? AppTheme.primaryColor
                          : AppTheme.cardColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text(
                      message['message']!,
                      style: TextStyle(
                        color: message['sender'] == 'user' ? Colors.white : AppTheme.textColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
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
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8.0),
                FloatingActionButton(
                  onPressed: _speechEnabled
                      ? (_speechToText.isListening ? _stopListening : _startListening)
                      : null,
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
                  child: const Icon(Icons.book, color: Colors.white), // Changed icon to book
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}