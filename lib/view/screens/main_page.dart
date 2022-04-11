import 'package:flutter/material.dart';

import 'map_screen.dart';
import 'cartable_screen.dart';
import 'orders_screen.dart';
import 'profile_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Map<String, dynamic>> _navbarItems = [
    {
      'appbarTitle': '',
      'title': 'نقشه',
      'icon': const Icon(Icons.map),
      'page': const MapScreen(),
    },
    {
      'appbarTitle': 'سفارش‌های آتی',
      'title': 'کارتابل',
      'icon': const Icon(Icons.timer_outlined),
      'page': const CartableScreen(),
    },
    {
      'appbarTitle': 'سفارشات',
      'title': 'سفارشات',
      'icon': const Icon(Icons.assignment),
      'page': const OrdersScreen(),
    },
    {
      'appbarTitle': 'پروفایل و پشتیبانی',
      'title': 'پروفایل',
      'icon': const Icon(Icons.person),
      'page': ProfileScreen(),
    },
  ];
  int _navbarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _navbarIndex == 0
          ? null
          : AppBar(
              centerTitle: true,
              title: Text(
                _navbarItems[_navbarIndex]['appbarTitle'],
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: _navbarItems
            .map(
              (item) => BottomNavigationBarItem(
                icon: item['icon'],
                label: item['title'],
              ),
            )
            .toList(),
        currentIndex: _navbarIndex,
        onTap: (pageIndex) {
          setState(() {
            _navbarIndex = pageIndex;
          });
        },
      ),
      body: _navbarItems[_navbarIndex]['page'],
    );
  }
}
