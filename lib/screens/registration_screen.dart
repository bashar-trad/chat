import 'package:chat_app/widgets/my_button.dart';
import 'package:chat_app/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String _email = '';
  String _password = '';

  void _handleEmailChanged(String email) {
    setState(() {
      _email = email;
    });
  }

  void _handlePasswordChanged(String password) {
    setState(() {
      _password = password;
    });
  }

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
            MyTextBox(
              title: 'Enter your Email',
              onChanged: _handleEmailChanged,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 8,
            ),
            MyTextBox(
              title: 'Enter your password',
              onChanged: _handlePasswordChanged,
              obscureText: true,
            ),
            const SizedBox(
              height: 8,
            ),
            MyButton(
              color: Colors.blue[900]!,
              title: 'Register',
              onPressed: () async {
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: _email, password: _password);
                  Navigator.pushNamed(context, 'chat_screen');
                  // print('Email: $_email');
                  // print('Password: $_password');
                } catch (e) {
                  print(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
