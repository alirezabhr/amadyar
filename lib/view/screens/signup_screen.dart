import 'package:amadyar/controllers/auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _companyCodeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isSubmitting = false;

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
                      // const Text('نام خود را وارد کنید:'),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 16.0,
                        ),
                        child: TextFormField(
                          controller: _firstNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'این فیلد نباید خالی باشد';
                            }
                            return null;
                          },
                          textDirection: TextDirection.rtl,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('نام'),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 6.0)),
                        ),
                      ),
                      // const Text('نام خانوادگی خود را وارد کنید:'),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 16.0,
                        ),
                        child: TextFormField(
                          controller: _lastNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'این فیلد نباید خالی باشد';
                            }
                            return null;
                          },
                          textDirection: TextDirection.rtl,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('نام و نام خانوادگی'),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 6.0)),
                        ),
                      ),
                      // const Text('کد شرکت را وارد کنید:'),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 16.0,
                        ),
                        child: TextFormField(
                          controller: _companyCodeController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'این فیلد نباید خالی باشد';
                            }
                            return null;
                          },
                          textDirection: TextDirection.rtl,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('کد شرکت'),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 6.0)),
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
                        setState(() {
                          _isSubmitting = true;
                        });

                        if (_formKey.currentState!.validate()) {
                          try {
                            await Auth.signup(context,
                                fistName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                companyCode: _companyCodeController.text);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('اطلاعات وارد شده اشتباه است')),
                            );
                          }
                        }

                        setState(() {
                          _isSubmitting = false;
                        });
                      },
                      child: _isSubmitting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              "ادامه",
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
