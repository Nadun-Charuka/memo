import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
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
  DateTime? selectedDate;
  final _contentController = TextEditingController();
  final _dateTimeController = TextEditingController();
  late String selectedImoji = "😍";
  List<String> items = ['😍', '😁', '🥺', '🤔', '😡', '😭', '🤮'];
  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _contentController.text = widget.note!.content;
      selectedDate = widget.note!.dateTime;
      _dateTimeController.text =
          DateFormat("dd-MM-yyyy").format(widget.note!.dateTime);
      selectedImoji = widget.note!.emoji;
    } else {
      selectedDate = DateTime.now();
      _dateTimeController.text =
          DateFormat("dd-MM-yyyy").format(DateTime.now());
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> dateTimePicker() async {
      DateTime? date = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );

      if (date == null) return;

      final DateTime dateTime = DateTime(
        date.year,
        date.month,
        date.day,
      );

      setState(() {
        selectedDate = DateTime(date.year, date.month, date.day);
        _dateTimeController.text = DateFormat("dd-MM-yyyy").format(dateTime);
      });
    }

    final isEditing = widget.note != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit Memo" : "Add Memo"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              TextField(
                minLines: 6,
                maxLines: 15,
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
                      padding: EdgeInsets.all(5),
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
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 250,
                        child: TextField(
                          readOnly: true,
                          controller: _dateTimeController,
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            labelText: "Set date manually",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onTap: dateTimePicker,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final content = _contentController.text.trim();
                      if (content.isNotEmpty) {
                        if (isEditing) {
                          ref.read(noteProvider.notifier).updateNote(
                              selectedImoji,
                              widget.note!.id,
                              content,
                              selectedDate!);
                        } else {
                          ref
                              .read(noteProvider.notifier)
                              .addNote(selectedImoji, content, selectedDate!);
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Enter title and content")));
                      }
                      Navigator.pop(context);
                    },
                    child: Text(isEditing ? "Edit" : "Add"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
