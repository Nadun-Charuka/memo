import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memo/models/note.dart';
import 'package:memo/providers/note_provider.dart';

class AddEditNoteScreen extends ConsumerStatefulWidget {
  final Note? note;
  const AddEditNoteScreen({this.note, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends ConsumerState<AddEditNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.note != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit note" : "Add note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(label: Text("Title")),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(label: Text("Content")),
            ),
            Spacer(),
            ElevatedButton(
                onPressed: () {
                  final title = _titleController.text.trim();
                  final content = _contentController.text.trim();

                  if (isEditing) {
                    ref
                        .read(noteProvider.notifier)
                        .updateNote(widget.note!.id, title, content);
                  } else {
                    ref.read(noteProvider.notifier).addNote(title, content);
                  }
                  Navigator.pop(context);
                },
                child: Text(isEditing ? "Edit" : "Add"))
          ],
        ),
      ),
    );
  }
}
