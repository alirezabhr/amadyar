import 'package:flutter/material.dart';
import 'package:amadyar/controllers/auth.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(28.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: SizedBox(
              height: deviceSize.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/images/amadyar_logo_32.png', width: 180),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('شماره موبایل خود را وارد کنید: '),
                      const Text(
                        '+98921xxxxxxx',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(color: Colors.black54),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 16.0,
                        ),
                        child: TextFormField(
                          controller: _phoneNumberController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'شماره موبایل را وارد نمایید.';
                            }
                            if (value.length != 10) {
                              return 'شماره موبایل نامعتبر است.';
                            }
                            return null;
                          },
                          textDirection: TextDirection.ltr,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('شماره موبایل'),
                              ),
                              suffix: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.0),
                                child:
                                    Text('+98', textDirection: TextDirection.ltr),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 6.0)),
                        ),
                      ),
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
                          await Auth.phoneNumberExists(
                            _phoneNumberController.text,
                            context,
                          );
                        }
                      },
                      child: Text(
                        "ادامه",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600
                        ),
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
