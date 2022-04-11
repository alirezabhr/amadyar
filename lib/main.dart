import 'package:amadyar/providers/user_provider.dart';
import 'package:amadyar/view/screens/phone_number_screen.dart';
import 'package:amadyar/view/screens/otp_request_screen.dart';
import 'package:amadyar/view/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes.dart';

import 'view/screens/main_page.dart';
import 'view/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => User()),
      ],
      child: MaterialApp(
        title: 'حمل و نقل آمادیار',
        theme: ThemeData(
          fontFamily: 'SamimFD',
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.green,
          ).copyWith(
              secondary: Colors.blueAccent,
              tertiary: const Color(0xDFE5F2FA)
          ),
        ),
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Container(child: child),
          );
        },
        initialRoute: PageRoutes.welcomeScreen,
        routes: {
          PageRoutes.welcomeScreen: (ctx) => const WelcomeScreen(),
          PageRoutes.phoneNumberScreen: (ctx) => const PhoneNumberScreen(),
          PageRoutes.otpScreen: (ctx) => const OtpScreen(),
          PageRoutes.signUpScreen: (ctx) => const SignupScreen(),
          PageRoutes.mainPage: (ctx) => const MainPage(),
        },
      ),
    );
  }
}
