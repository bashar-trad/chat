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
  bool showPasswordError = false;

  void _handleEmailChanged(String email) {
    setState(() {
      _email = email;
      showEmailError = _email.isEmpty;
    });
  }

  void _handlePasswordChanged(String password) {
    setState(() {
      _password = password;
      showPasswordError = _password.isEmpty;
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
              Visibility(
                visible: showEmailError,
                child: const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Email is required.',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              MyTextBox(
                title: 'Enter your password',
                onChanged: _handlePasswordChanged,
                obscureText: true,
              ),
              Visibility(
                visible: showPasswordError,
                child: const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Password is required.',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              MyButton(
                color: Colors.blue[900]!,
                title: 'Register',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });

                  // التحقق من صحة الإدخال
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
                    Navigator.pushNamedAndRemoveUntil(context, 'chat_screen',
                        (Route<dynamic> route) => false);
                  } on FirebaseAuthException catch (e) {
                    // التعامل مع الأخطاء الخاصة بـ Firebase
                    setState(() {
                      showSpinner = false;
                      if (e.code == 'weak-password') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('The password is too weak.'),
                          ),
                        );
                      } else if (e.code == 'email-already-in-use') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'The account already exists for that email.'),
                          ),
                        );
                      } else if (e.code == 'invalid-email') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('The email address is not valid.'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: ${e.message}'),
                          ),
                        );
                      }
                    });
                  } catch (e) {
                    // التعامل مع الأخطاء العامة
                    setState(() {
                      showSpinner = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Unexpected error: ${e.toString()}'),
                      ),
                    );
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
