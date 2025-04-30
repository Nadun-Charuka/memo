import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:memo/providers/filterd_note_provider.dart';
import 'package:memo/providers/note_provider.dart';
import 'package:memo/screens/add_edit_note_screen.dart';
import 'package:memo/screens/setting_screen.dart';

import 'package:memo/widgets/searchbar_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(filteredNotesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
            ),
            Text(
              " Memo – Save the feels.",
              style: GoogleFonts.dancingScript(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingScreen()));
              },
              icon: Icon(Icons.person))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SearchbarWidget(),
            Divider(),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SingleChildScrollView(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Spacer(
                                        flex: 10,
                                      ),
                                      Text(
                                        note.emoji,
                                        style: TextStyle(fontSize: 30),
                                      ),
                                      Spacer(
                                        flex: 6,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  AddEditNoteScreen(note: note),
                                            ),
                                          );
                                        },
                                        child: Icon(
                                          Icons.edit,
                                        ),
                                      ),
                                      Spacer(
                                        flex: 2,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          bool? confirmDelete =
                                              await showDialog<bool>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Delete Memo?'),
                                                content: Text(
                                                    'Are you sure you want to delete this memo?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, false);
                                                    },
                                                    child: Text(
                                                      'No',
                                                      style: TextStyle(
                                                        color: Colors.redAccent,
                                                      ),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, true);
                                                    },
                                                    child: Text('Yes'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );

                                          if (confirmDelete == true) {
                                            ref
                                                .read(noteProvider.notifier)
                                                .deleteNote(note.id);
                                            if (!context.mounted) return;

                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                backgroundColor: Colors
                                                    .redAccent
                                                    .withValues(alpha: 0.4),
                                                content: Text('Memo deleted'),
                                              ),
                                            );
                                          }
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(note.content),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        DateFormat("dd-MM-yyyy  hh:mm a")
                                            .format(note.dateTime),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("close"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  note.emoji,
                                  style: TextStyle(fontSize: 24),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              note.content,
                              style: GoogleFonts.lora(
                                fontSize: 16,
                              ),
                              maxLines: 15,
                              overflow: TextOverflow.fade,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              DateFormat("dd-MM-yyyy").format(note.dateTime),
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
