import 'package:amadyar/models/auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneNumberControler = TextEditingController();
  final passwordControler = TextEditingController();

  String errorMessage = "";
  
  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.all(28.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
        children: [
            TextField(
              controller: phoneNumberControler,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'شماره تفلن هراه',
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  await Auth.phoneNumberExists(phoneNumberControler.text, context);
                },
                child: const Text("submit")),
            Text(errorMessage),
      ],
    ),
          ),
   );
  }
}
