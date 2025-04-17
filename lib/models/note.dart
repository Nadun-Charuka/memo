import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String emoji;
  @HiveField(2)
  final String content;
  @HiveField(3)
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
