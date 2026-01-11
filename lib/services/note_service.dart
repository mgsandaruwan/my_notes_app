import '../config/supabase_config.dart';
import '../models/note.dart';

class NoteService {
  // Fetch all notes
  Future<List<Note>> fetchNotes() async {
    try {
      final response = await supabase
          .from('notes')
          .select()
          .order('created_at', ascending: false);

      return (response as List).map((note) => Note.fromJson(note)).toList();
    } catch (e) {
      throw Exception('Error loading notes: $e');
    }
  }

  // Create new note
  Future<void> createNote(String title, String description) async {
    try {
      await supabase.from('notes').insert({
        'title': title,
        'description': description,
      });
    } catch (e) {
      throw Exception('Error creating note: $e');
    }
  }

  // Update note
  Future<void> updateNote(String id, String title, String description) async {
    try {
      await supabase.from('notes').update({
        'title': title,
        'description': description,
      }).eq('id', id);
    } catch (e) {
      throw Exception('Error updating note: $e');
    }
  }

  // Delete note
  Future<void> deleteNote(String id) async {
    try {
      await supabase.from('notes').delete().eq('id', id);
    } catch (e) {
      throw Exception('Error deleting note: $e');
    }
  }

  // Toggle favorite
  Future<void> toggleFavorite(String id, bool currentStatus) async {
    try {
      await supabase
          .from('notes')
          .update({'is_favorite': !currentStatus})
          .eq('id', id);
    } catch (e) {
      throw Exception('Error updating favorite: $e');
    }
  }
}