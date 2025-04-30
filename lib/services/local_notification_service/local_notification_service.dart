import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:memo/models/notification_time.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    const DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> showSheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime dateTime,
  }) async {
    NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        "channelId",
        "channelName",
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(dateTime, tz.local),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}

Future<void> rescheduleNotifications() async {
  final box = Hive.box<NotificationTime>('notificationBox');
  final morning = box.get('morning');
  final evening = box.get('evening');
  final now = DateTime.now();

  if (morning != null) {
    await LocalNotificationService.showSheduleNotification(
      id: 1,
      title: 'Memo Reminder',
      body: 'Did you forget to add Memo?',
      dateTime:
          DateTime(now.year, now.month, now.day, morning.hour, morning.minute),
    );
  }

  if (evening != null) {
    await LocalNotificationService.showSheduleNotification(
      id: 2,
      title: 'Memo Reminder',
      body: 'Save your Memo today',
      dateTime:
          DateTime(now.year, now.month, now.day, evening.hour, evening.minute),
    );
  }
}
