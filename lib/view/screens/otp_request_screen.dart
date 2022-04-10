import 'package:amadyar/routes.dart';
import 'package:flutter/material.dart';
import '../../controllers/auth.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(28),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: SizedBox(
              height: deviceSize.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/amadyar_logo_32.png', width: 180),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('کد یکبار مصرف را وارد کنید:'),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 16.0),
                          child: TextFormField(
                            controller: _otpCodeController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'کد یکبار مصرف را وارد کنید:';
                              } else if (value.length != 6) {
                                return 'کد ۶ رقمی وارد کنید';
                              } else if (!isNumeric(value)) {
                                return 'ارقام معتبر وارد کنید';
                              }
                              return null;
                            },
                            textDirection: TextDirection.ltr,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text('کد یکبار مصرف'),
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 6.0)),
                          )),
                      TextButton(onPressed: () {
                        Navigator.pushReplacementNamed(context, PageRoutes.loginScreen);
                      }, child: Text('تغییر شماره', style: TextStyle(color: Theme.of(context).colorScheme.primary),))
                    ],
                  ),
                  SizedBox(
                    width: (deviceSize.width * 2) / 5,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        side: BorderSide(
                          width: 2,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await Auth.login(
                            _otpCodeController.text,
                            context,
                          );
                        }
                      },
                      child: Text(
                        "ثیت",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
