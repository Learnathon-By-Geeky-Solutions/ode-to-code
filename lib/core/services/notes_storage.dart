import 'package:shared_preferences/shared_preferences.dart';

class NotesStorage {
  static const String _notesKey = 'video_notes';

  static Future<List<String>> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_notesKey) ?? [];
  }

  static Future<void> saveNotes(List<String> notes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_notesKey, notes);
  }
}
