import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memo/providers/note_provider.dart';
import 'package:memo/screens/add_edit_note_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(noteProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes App"),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return ListTile(
            title: Text(note.title),
            subtitle: Text(note.content),
            trailing: IconButton(
              onPressed: () {
                ref.read(noteProvider.notifier).deleteNote(note.id);
              },
              icon: Icon(Icons.delete),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddEditNoteScreen(
                    note: note,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddEditNoteScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
