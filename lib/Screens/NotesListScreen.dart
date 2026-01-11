import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key});

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  List<Note> notes = [];
  bool showFavorites = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    setState(() => isLoading = true);
    try {
      final response = await supabase
          .from('notes')
          .select()
          .order('created_at', ascending: false);

      setState(() {
        notes = (response as List).map((note) => Note.fromJson(note)).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading notes: $e')),
        );
      }
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      await supabase.from('notes').delete().eq('id', id);
      fetchNotes();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting note: $e')),
        );
      }
    }
  }

  Future<void> toggleFavorite(Note note) async {
    try {
      await supabase
          .from('notes')
          .update({'is_favorite': !note.isFavorite})
          .eq('id', note.id);
      fetchNotes();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating note: $e')),
        );
      }
    }
  }

  List<Note> get filteredNotes {
    if (showFavorites) {
      return notes.where((note) => note.isFavorite).toList();
    }
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MY',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Notes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => showFavorites = false),
                          child: Column(
                            children: [
                              Text(
                                'All',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 2,
                                color: showFavorites ? Colors.transparent : Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => showFavorites = true),
                          child: Column(
                            children: [
                              Text(
                                'Favorite',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 2,
                                color: showFavorites ? Colors.white : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredNotes.isEmpty
                  ? Center(
                child: Text(
                  showFavorites ? 'No favorite notes' : 'No notes yet',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: filteredNotes.length,
                itemBuilder: (context, index) {
                  final note = filteredNotes[index];
                  return NoteCard(
                    note: note,
                    onEdit: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddEditNoteScreen(note: note),
                        ),
                      );
                      fetchNotes();
                    },
                    onDelete: () => deleteNote(note.id),
                    onToggleFavorite: () => toggleFavorite(note),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEditNoteScreen()),
          );
          fetchNotes();
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.black, size: 32),
      ),
    );
  }
}
