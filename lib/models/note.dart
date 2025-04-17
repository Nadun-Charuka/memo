import 'package:uuid/uuid.dart';

class Note {
  final String id;
  final String emoji;
  final String content;
  final DateTime dateTime;

  Note({
    String? id,
    required this.emoji,
    required this.content,
    required this.dateTime,
  }) : id = id ?? Uuid().v4();

  Note copyWith({String? emoji, String? content, DateTime? dateTime}) {
    return Note(
      id: id,
      emoji: emoji ?? this.emoji,
      content: content ?? this.content,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
