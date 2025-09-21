import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class JournalService {
  // IMPORTANT: Replace this with your actual API key.
  // It is strongly recommended to use a secure method (like environment variables or a secrets manager) to handle your API key.
  static const String _apiKey = 'YOUR_API_KEY_HERE';

  final GenerativeModel _model;

  JournalService() : _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: _apiKey);

  Future<String> getResponse(String message) async {
    try {
      final content = [Content.text(message)];
      final response = await _model.generateContent(content);
      return response.text ?? 'I am sorry, I could not process that.';
    } catch (e) {
      // Log the error for debugging
      debugPrint('Error generating content: $e');
      return 'There was an error with the AI service. Please try again later.';
    }
  }

  // Method to save a journal entry
  void saveJournalEntry(String entry) {
    debugPrint('Journal Entry Saved: $entry');
    // In a real application, you would save this to a database or local storage.
  }
}
