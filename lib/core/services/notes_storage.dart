import 'package:shared_preferences/shared_preferences.dart';

class NotesStorage {
  static const String _notesKey = 'videonotes';

  static Future<List<String>> loadNotes(String contentId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_getNotesKey(contentId)) ?? [];
  }

  static Future<void> saveNotes(List<String> notes, String contentId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_getNotesKey(contentId), notes);
  }

  static String _getNotesKey(String contentId) {
    return '$_notesKey$contentId';
  }
}
