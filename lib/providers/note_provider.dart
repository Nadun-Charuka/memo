import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memo/models/note.dart';

class NoteNotifier extends StateNotifier<List<Note>> {
  NoteNotifier() : super([]);

  void addNote(String emoji, String content, DateTime dateTime) {
    final newNote = Note(emoji: emoji, content: content, dateTime: dateTime);
    state = [...state, newNote];
  }

  void updateNote(String emoji, String id, String content, DateTime dateTime) {
    state = state.map((note) {
      if (note.id == id) {
        return note.copyWith(
            emoji: emoji, content: content, dateTime: dateTime);
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
