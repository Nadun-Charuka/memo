// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_time.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationTimeAdapter extends TypeAdapter<NotificationTime> {
  @override
  final int typeId = 1;

  @override
  NotificationTime read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationTime(
      fields[0] as int,
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationTime obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.hour)
      ..writeByte(1)
      ..write(obj.minute);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationTimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
