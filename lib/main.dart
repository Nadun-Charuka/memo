import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:memo/models/note.dart';
import 'package:memo/models/notification_time.dart';
import 'package:memo/providers/theme_provider.dart';
import 'package:memo/screens/home_screen.dart';
import 'package:memo/services/local_notification_service/local_notification_service.dart';
import 'package:memo/utils/theme.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  tz.initializeTimeZones();
  await LocalNotificationService.init();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>('notesBox');
  await Hive.openBox('settings');

  //notifications

  Hive.registerAdapter(NotificationTimeAdapter());
  await Hive.openBox<NotificationTime>('notificationBox');
  await rescheduleNotifications();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);
    return MaterialApp(
      title: "Memo App",
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: MyAppThemes.lightTheme,
      darkTheme: MyAppThemes.darkTheme,
      themeMode: themeMode,
    );
  }
}
