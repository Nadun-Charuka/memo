import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:memo/models/notification_time.dart';

final notificationBoxProvider = Provider<Box<NotificationTime>>((ref) {
  return Hive.box<NotificationTime>('notificationBox');
});

final morningTimeProvider = StateProvider<NotificationTime?>((ref) {
  return ref.watch(notificationBoxProvider).get('morning');
});

final eveningTimeProvider = StateProvider<NotificationTime?>((ref) {
  return ref.watch(notificationBoxProvider).get('evening');
});
