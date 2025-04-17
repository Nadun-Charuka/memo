import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memo/screens/home_screen.dart';
import 'package:memo/theme.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Memo App",
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: MyAppThemes.darkTheme,
    );
  }
}
