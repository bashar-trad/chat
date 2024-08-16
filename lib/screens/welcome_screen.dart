import 'package:flutter/material.dart';
import 'package:chat_app/widgets/my_button.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          
          padding: const EdgeInsets.symmetric(horizontal:24 ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch ,
            children: [
              Column(
                children: [
                  Container(
                    height: 180,
                    child: Image.asset('images/chat_app.png'),
                  ),
                  const Text(
                    'Messgme',
                  style:TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff2e386b),
                  )
                  ),
                ],
              ),
              SizedBox(height: 30,),
              MyButton(
                color: Colors.yellow[900]!,
                title: 'sing in',
                onPressed: (){},
              ),
             
              MyButton(
                color: Colors.blue[800]!,
                title: 'Register',
                onPressed: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

