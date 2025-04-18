import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memo/providers/theme_provider.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              ref.read(themeNotifierProvider.notifier).toggleTheme();
            },
          )
        ],
      ),
      body: Center(),
    );
  }
}
