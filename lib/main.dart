import 'package:chat_app/screens/chat_screen.dart';
//import 'package:chat_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';
//import 'package:chat_app/screens/welcome_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'chat_app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ChatScreen(),
    );
  }
}