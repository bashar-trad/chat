import 'package:chat_app/widgets/my_textfield.dart';
import 'package:chat_app/widgets/my_button.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 180,
              child: Image.asset('images/chat_app.png'),
            ),
            const SizedBox(
              height: 50,
            ),
            myTextBox(title: 'Enter your Email'),
            SizedBox(
              height: 8,
            ),
            myTextBox(title: 'Enter your password'),
            SizedBox(
              height: 8,
            ),
            MyButton(
                color: Colors.blue[900]!, title: 'Register', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
