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
                  fontWeight: FontWeight.bold, fontSize: 25),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddEditNoteScreen(note: note),
                        ),
                      );
                    },
                    child: Card(
                      //color: Color(0xFF3A3A3A),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  note.emoji,
                                  style: TextStyle(fontSize: 24),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(noteProvider.notifier)
                                        .deleteNote(note.id);
                                  },
                                  child: Icon(Icons.delete, size: 20),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              note.content,
                              style: GoogleFonts.lora(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              DateFormat("dd-MM-yyyy").format(note.dateTime),
                              //note.dateTime.toString(),
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
