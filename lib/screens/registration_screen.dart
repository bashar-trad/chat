import 'package:chat_app/widgets/my_button.dart';
import 'package:chat_app/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String _email = '';
  String _password = '';
  bool showSpinner = false;
  bool showEmailError = false;
  bool showPasswordError=false;
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
              Visibility(
                visible: showEmailError,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Email is required.',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              MyTextBox(
                title: 'Enter your password',
                onChanged: _handlePasswordChanged,
                obscureText: true,
              ),
              const SizedBox(
                height: 8,
              ),
              Visibility(
                visible: showPasswordError,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Password is required.',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              
              MyButton(
                color: Colors.blue[900]!,
                title: 'Register',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  if (_email.isEmpty || _password.isEmpty) {
                    setState(() {
                      showSpinner = false;
                      showEmailError = _email.isEmpty;
                      showPasswordError = _password.isEmpty;
                    });
                    return;
                  }
                  try {
                    await _auth.createUserWithEmailAndPassword(
                        email: _email, password: _password);
                    Navigator.pushNamed(context, 'chat_screen');
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${e.toString()}'),
                      ),
                    );
                  } finally {
                    setState(() {
                      showSpinner = false;
                    });
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
