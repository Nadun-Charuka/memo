import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:memo/models/note.dart';

class NoteNotifier extends StateNotifier<List<Note>> {
  late Box<Note> _noteBox;
  NoteNotifier() : super([]) {
    _noteBox = Hive.box<Note>('notesBox');
    loadNotes();
  }

  void loadNotes() {
    state = _noteBox.values.toList();
  }

  void addNote(String emoji, String content, DateTime dateTime) {
    final newNote = Note(emoji: emoji, content: content, dateTime: dateTime);
    _noteBox.put(newNote.id, newNote);
    loadNotes();
  }

  void updateNote(String emoji, String id, String content, DateTime dateTime) {
    final note = _noteBox.get(id);
    if (note != null) {
      final updated =
          note.copyWith(content: content, emoji: emoji, dateTime: dateTime);

      _noteBox.put(id, updated);
    }
  }

  void deleteNote(String id) {
    _noteBox.delete(id);
    loadNotes();
  }
}

final noteProvider =
    StateNotifierProvider<NoteNotifier, List<Note>>((ref) => NoteNotifier());
