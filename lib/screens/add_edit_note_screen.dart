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
  final _contentController = TextEditingController();
  late String selectedImoji = "😍";
  List<String> items = ['😍', '😡', '🥹', '😁', '🤔'];
  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _contentController.text = widget.note!.content;
      selectedImoji = widget.note!.emoji;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.note != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit Memo" : "Add Memo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextField(
              minLines: 3,
              maxLines: 6,
              controller: _contentController,
              decoration: InputDecoration(
                  label: Text("Memo"), alignLabelWithHint: true),
            ),
            SizedBox(
              height: 10,
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: items.map((emoji) {
                final isSelected = emoji == selectedImoji;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImoji = emoji;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.blue.shade100
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      emoji,
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  final content = _contentController.text.trim();

                  if (content.isNotEmpty) {
                    if (isEditing) {
                      ref.read(noteProvider.notifier).updateNote(selectedImoji,
                          widget.note!.id, content, DateTime.now());
                    } else {
                      ref
                          .read(noteProvider.notifier)
                          .addNote(selectedImoji, content, DateTime.now());
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Enter title and content")));
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
