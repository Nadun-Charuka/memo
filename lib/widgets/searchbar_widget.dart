import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memo/providers/filterd_note_provider.dart';

class SearchbarWidget extends ConsumerWidget {
  const SearchbarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEmoji = ref.watch(selectedEmojiProvider);
    final selectedDate = ref.watch(selectedDateProvider);

    final emojis = ['😍', '😁', '🤔', '😡', '😭', '🤮'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Field
        TextField(
          decoration: InputDecoration(
            hintText: 'Search by emoji or content...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onChanged: (value) =>
              ref.read(searchQueryProvider.notifier).state = value,
        ),
        const SizedBox(height: 10),

        // Emoji Filter Row
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: emojis.length,
            itemBuilder: (context, index) {
              final emoji = emojis[index];
              final isSelected = selectedEmoji == emoji;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: () {
                    ref.read(selectedEmojiProvider.notifier).state =
                        isSelected ? null : emoji;
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      emoji,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),

        // Date Filter Button
        Row(
          children: [
            Text(
              selectedDate == null
                  ? "No date selected"
                  : "📅 ${selectedDate.toString().split(' ')[0]}",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              icon: Icon(Icons.calendar_today),
              label: Text("Pick Date"),
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate ?? DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  ref.read(selectedDateProvider.notifier).state = picked;
                }
              },
            ),
            if (selectedDate != null)
              IconButton(
                icon: Icon(Icons.clear),
                onPressed: () =>
                    ref.read(selectedDateProvider.notifier).state = null,
              ),
          ],
        )
      ],
    );
  }
}
