import 'dart:async';

import 'package:amadyar/controllers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';
import '../../models/user.dart';
import '../../controllers/history_orders_provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Timer _timer;
  double _progress = 3;

  _loadData() async {
    bool _userAuthenticated = await Auth.isLoggedIn();
    if (_userAuthenticated) {
      // TODO: add error handling if not connected to wifi
      Provider.of<User>(context, listen: false).updateUser();
      Provider.of<HistoryOrdersProvider>(context, listen: false).updateOrders();
      Navigator.pushReplacementNamed(context, PageRoutes.mainPage);
    } else {
      Navigator.pushReplacementNamed(context, PageRoutes.phoneNumberScreen);
    }
  }

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) => setState(
        () {
          if (_progress == 0) {
            _timer.cancel();
            _loadData();
          } else {
            _progress -= 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    const double smallLogoSize = 100;
    const double bigLogoSize = 200;

    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final Size biggest = constraints.biggest;
          return Stack(
            children: <Widget>[
              PositionedTransition(
                rect: RelativeRectTween(
                  begin: RelativeRect.fromSize(
                      Rect.fromLTWH(
                          biggest.width + bigLogoSize,
                          biggest.height / 2 - 50,
                          smallLogoSize,
                          smallLogoSize),
                      biggest),
                  end: RelativeRect.fromSize(
                      Rect.fromLTWH(
                          (biggest.width - bigLogoSize) / 2,
                          (biggest.height - bigLogoSize - 100) / 2,
                          bigLogoSize,
                          bigLogoSize),
                      biggest),
                ).animate(CurvedAnimation(
                  parent: _controller,
                  curve: Curves.elasticInOut,
                )),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Image(
                    image: AssetImage('assets/images/amadyar_logo_32.png'),
                  ),
                ),
              ),
              PositionedTransition(
                rect: RelativeRectTween(
                  begin: RelativeRect.fromSize(
                      Rect.fromLTWH(
                        (0 - deviceSize.width) / 2,
                        (biggest.height + 100) / 2,
                        deviceSize.width / 2,
                        75,
                      ),
                      biggest),
                  end: RelativeRect.fromSize(
                      Rect.fromLTWH(
                        (biggest.width - deviceSize.width) / 2,
                        (biggest.height + 100) / 2,
                        deviceSize.width,
                        75,
                      ),
                      biggest),
                ).animate(CurvedAnimation(
                  parent: _controller,
                  curve: Curves.elasticInOut,
                )),
                child: Column(
                  children: [
                    const Text(
                      'حمل و نقل بهینه با',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'آمادیار',
                      style: TextStyle(color: Theme.of(context).colorScheme.primary,
                          fontSize: 22, fontWeight: FontWeight.bold,),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                left: (biggest.width - 100) / 2,
                child: SizedBox(
                  width: 80,
                  child: Column(
                    children: [
                      Divider(
                        color: Theme.of(context).colorScheme.primary,
                        thickness: 1.5,
                      ),
                      const Center(
                        child: Text(
                          'نسخه 1.0.0',
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
