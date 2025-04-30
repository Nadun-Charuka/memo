import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memo/providers/notification_provider.dart';
import 'package:memo/providers/theme_provider.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allowNotification = ref.watch(allowNotificationProvider);
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
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Theme setting: ",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 22,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                IconButton(
                  color: isDark ? Colors.yellow : Colors.blueGrey,
                  splashColor: Colors.pink
                      .withValues(alpha: .3), // Splash effect when pressed
                  highlightColor: Colors.pink
                      .withValues(alpha: 0.1), // Highlight color when tapped
                  icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                  onPressed: () {
                    ref.read(themeNotifierProvider.notifier).toggleTheme();
                  },
                )
              ],
            ),
            Row(
              children: [
                Text(
                  "Notification setting: ",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 22,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Switch(
                  activeColor: Colors.pinkAccent,
                  value: allowNotification,
                  onChanged: (value) {
                    ref.read(allowNotificationProvider.notifier).state = value;
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
