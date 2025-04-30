import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:memo/models/notification_time.dart';
import 'package:memo/providers/notification_time_provider.dart';
import 'package:memo/providers/theme_provider.dart';
import 'package:memo/services/local_notification_service/local_notification_service.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;

    final box = Hive.box<NotificationTime>('notificationBox');

    final morning = box.get('morning');
    if (morning != null) {
      _morningTime = TimeOfDay(hour: morning.hour, minute: morning.minute);
      _morningController.text = _morningTime!.format(context);
      ref.read(morningTimeProvider.notifier).state = morning;
    }

    final evening = box.get('evening');
    if (evening != null) {
      _eveningTime = TimeOfDay(hour: evening.hour, minute: evening.minute);
      _eveningController.text = _eveningTime!.format(context);
      ref.read(eveningTimeProvider.notifier).state = evening;
    }

    _initialized = true;
  }

  TimeOfDay? _morningTime;
  TimeOfDay? _eveningTime;

  final TextEditingController _morningController = TextEditingController();
  final TextEditingController _eveningController = TextEditingController();

  void _scheduleNotifications() async {
    FocusScope.of(context).unfocus();
    if (_morningTime == null || _eveningTime == null) return;

    final now = DateTime.now();
    final morningDateTime = DateTime(
        now.year, now.month, now.day, _morningTime!.hour, _morningTime!.minute);
    final eveningDateTime = DateTime(
        now.year, now.month, now.day, _eveningTime!.hour, _eveningTime!.minute);

    await LocalNotificationService.showSheduleNotification(
        id: 1,
        title: 'Memo Reminder',
        body: 'Did you forget to add Memo?',
        dateTime: morningDateTime);
    await LocalNotificationService.showSheduleNotification(
      id: 2,
      title: 'Memo Reminder',
      body: 'Save your Memo today',
      dateTime: eveningDateTime,
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Notification scheduled successfully")));
  }

  Future<void> _pickTime({required bool isMorning}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked == null) return;

    final box = Hive.box<NotificationTime>('notificationBox');
    final time = NotificationTime(picked.hour, picked.minute);

    if (isMorning) {
      if (!mounted) return;
      _morningTime = picked;
      _morningController.text = picked.format(context);
      box.put('morning', time);
      ref.read(morningTimeProvider.notifier).state = time;
    } else {
      if (!mounted) return;
      _eveningTime = picked;
      _eveningController.text = picked.format(context);
      box.put('evening', time);
      ref.read(eveningTimeProvider.notifier).state = time;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeNotifierProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: GoogleFonts.dancingScript(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Theme setting: ",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 22),
                ),
                SizedBox(width: 30),
                IconButton(
                  color: isDark ? Colors.yellow : Colors.blueGrey,
                  icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                  onPressed: () {
                    ref.read(themeNotifierProvider.notifier).toggleTheme();
                  },
                )
              ],
            ),
            Divider(),
            SizedBox(height: 20),
            Text(
              "Notification setting: ",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 22),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _morningController,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: "Morning Time",
                              border: OutlineInputBorder(),
                            ),
                            onTap: () => _pickTime(isMorning: true),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: TextField(
                            controller: _eveningController,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: "Evening Time",
                              border: OutlineInputBorder(),
                            ),
                            onTap: () => _pickTime(isMorning: false),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _scheduleNotifications,
                      child: Text("Set Notifications"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
