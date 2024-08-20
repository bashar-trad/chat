import 'package:chat_app/widgets/my_button.dart';
import 'package:chat_app/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _auth = FirebaseAuth.instance;
  String _email = '';
  String _password = '';
  bool showSpinner=false;
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
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
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
                color: Colors.yellow[900]!,
                title: 'Sign in',
                onPressed: () async {
                  setState(() {
                    showSpinner=true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: _email, password: _password);
                    if (user != null) {
                      Navigator.pushNamed(context, 'chat_screen');
                      setState(() {
                        showSpinner=false;
                      });
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
