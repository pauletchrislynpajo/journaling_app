

// Now let's create our main app (lib/main.dart)
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const JournalApp());
}

class JournalApp extends StatelessWidget {
  const JournalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        debugShowCheckedModeBanner: false,
      ),
      home: const LoginScreen(),
    );
  }
}