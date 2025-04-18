import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memo/models/note.dart';
import 'package:memo/providers/note_provider.dart';

/// Text-based search input (emoji or content)
final searchQueryProvider = StateProvider<String>((ref) => '');

/// Selected emoji filter
final selectedEmojiProvider = StateProvider<String?>((ref) => null);

/// Selected date filter (e.g., filter by exact day)
final selectedDateProvider = StateProvider<DateTime?>((ref) => null);

/// Combines all filters into one provider
final filteredNotesProvider = Provider<List<Note>>((ref) {
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final emoji = ref.watch(selectedEmojiProvider);
  final selectedDate = ref.watch(selectedDateProvider);
  final notes = ref.watch(noteProvider);

  return notes.where((note) {
    final matchesQuery = query.isEmpty ||
        note.content.toLowerCase().contains(query) ||
        note.emoji.contains(query);

    final matchesEmoji = emoji == null || note.emoji == emoji;

    final matchesDate = selectedDate == null ||
        (note.dateTime.year == selectedDate.year &&
            note.dateTime.month == selectedDate.month &&
            note.dateTime.day == selectedDate.day);

    return matchesQuery && matchesEmoji && matchesDate;
  }).toList()
    ..sort((a, b) => b.dateTime.compareTo(a.dateTime)); // Newest first
});
