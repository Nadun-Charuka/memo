import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:memo/models/note.dart';
import 'package:memo/providers/theme_provider.dart';
import 'package:memo/screens/home_screen.dart';
import 'package:memo/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>('notesBox');
  await Hive.openBox('settings');
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
