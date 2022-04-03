import 'package:flutter/material.dart';

import 'routes.dart';

import 'view/screens/main_page.dart';

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
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(child: child)
        );
      },
      initialRoute: PageRoutes.mainPage,
      routes: {
        PageRoutes.mainPage: (ctx) => MainPage(),
      }
    );
  }
}
