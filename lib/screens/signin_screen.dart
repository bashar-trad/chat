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
              const SizedBox(
                height: 8,
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
              MyButton(
                color: Colors.yellow[900]!,
                title: 'Sign in',
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
                    await _auth.signInWithEmailAndPassword(
                        email: _email, password: _password);
                    Navigator.pushNamedAndRemoveUntil(context, 'chat_screen',
                        (Route<dynamic> route) => false);
                  } on FirebaseAuthException catch (e) {
                    setState(() {
                      showSpinner = false;
                    });

                    // التعامل مع الأخطاء الخاصة بـ Firebase
                    String errorMessage;
                    switch (e.code) {
                      case 'user-not-found':
                        errorMessage = 'No user found for that email.';
                        break;
                      case 'wrong-password':
                        errorMessage = 'Wrong password provided for that user.';
                        break;
                      case 'invalid-email':
                        errorMessage = 'The email address is not valid.';
                        break;
                      case 'too-many-requests':
                        errorMessage =
                            'Access to this account has been temporarily disabled due to many failed login attempts. Please try again later or reset your password.';
                        break;
                      default:
                        errorMessage = 'Error: ${e.message}';
                        break;
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(errorMessage),
                      ),
                    );
                  } catch (e) {
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
