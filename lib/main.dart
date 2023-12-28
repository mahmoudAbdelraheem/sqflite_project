import 'package:flutter/material.dart';
import 'add_note.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter SQFlite Note App',
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: const HomePage(),
      routes: {
        "addNote": (context) => const AddNote(),
      },
    );
  }
}
