import 'package:flutter/material.dart';
import 'package:hotel_ayo/auth/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hotel Ayo',
      theme: ThemeData(
        /* light theme settings */
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        /* dark theme settings */
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      home: const Login(),
    );
  }
}
