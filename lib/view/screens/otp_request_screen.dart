import 'package:flutter/material.dart';
import '../../models/auth.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({Key? key}) : super(key: key);

  final otpCodeController = TextEditingController();
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.all(28.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
        children: [
            TextField(
              controller: otpCodeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'کد دریافتی را وارد کنید',
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  bool isCorrect = await Auth.otpIsCorrect(otpCodeController.text, context);
                  if(!isCorrect){
                    message = 'کد وارد شده اشتباه است';                   
                  }else{
                    message = '';
                  }
                },
                child: const Text('ثبت')),
      Text(message, style: const TextStyle(fontSize: 14),),
      ],
    ),
          ),
   );
  }
}