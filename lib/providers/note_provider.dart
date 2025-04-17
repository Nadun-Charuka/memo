import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memo/models/note.dart';
import 'package:uuid/uuid.dart';

class NoteNotifier extends StateNotifier<List<Note>> {
  NoteNotifier() : super([]);

  void addNote(String title, String content) {
    final newNote = Note(id: Uuid().v4(), title: title, content: content);
    state = [...state, newNote];
  }

  void updateNote(String id, String title, String content) {
    state = state.map((note) {
      if (note.id == id) {
        return note.copyWith(title: title, content: content);
      }
      return note;
    }).toList();
  }

  void deleteNote(String id) {
    state = state.where((note) => note.id != id).toList();
  }
}

final noteProvider =
    StateNotifierProvider<NoteNotifier, List<Note>>((ref) => NoteNotifier());
