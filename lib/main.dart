import 'package:flutter/material.dart';

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
    return MaterialApp(
      title: 'حمل و نقل آمادیار',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SamimFD'
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(child: child)
        );
      },
      initialRoute: PageRoutes.welcomeScreen,
      routes: {
        PageRoutes.welcomeScreen: (ctx) => WelcomeScreen(),
        PageRoutes.mainPage: (ctx) => const MainPage(),
      }
    );
  }
}
