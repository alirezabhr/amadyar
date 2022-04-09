import 'package:amadyar/routes.dart';
import 'package:flutter/material.dart';
import '../../controllers/auth.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({Key? key}) : super(key: key);

  final otpCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    const double smallLogoSize = 100;
    const double bigLogoSize = 200;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
                  padding: EdgeInsets.all(8),
                  child: Image(
                    image: AssetImage('assets/images/amadyar_logo_32.png'),
                  ),
                ),
            const Text(
              'کد بکبار مصرف را وارد کنید',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
            TextField(
              controller: otpCodeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                // hintText: ,
              ),
            ),
            TextButton(onPressed: () => Navigator.pushReplacementNamed(context, PageRoutes.phoneNumberScreen), child: const Text('تغییر شماره', style: TextStyle(fontSize: 10),)),
            ElevatedButton(
                onPressed: () async {
                  String otpCode = otpCodeController.text;
                  bool isCorrect = await Auth.login(otpCode, context);
                  if (!isCorrect) {
                    const snackBar =
                        SnackBar(content: Text('کد ورودی اشتباه است'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: const Text('ثبت')),
          ],
        ),
      ),
    );
  }
}
