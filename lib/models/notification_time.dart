import 'package:hive/hive.dart';

part 'notification_time.g.dart';

@HiveType(typeId: 1)
class NotificationTime {
  @HiveField(0)
  final int hour;

  @HiveField(1)
  final int minute;

  NotificationTime(this.hour, this.minute);
}
