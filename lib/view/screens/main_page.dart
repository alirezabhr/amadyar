import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Map<String, dynamic>> _navbarItems = [
    {
      'title': 'نقشه',
      'icon': Icons.map,
      'page': Container(color: Colors.deepOrange,),
    },
    {
      'title': 'todo',
      'icon': Icons.timer_outlined,
      'page': Container(color: Colors.yellow),
    },
    {
      'title': 'سفارشات',
      'icon': Icons.check,
      'page': Container(color: Colors.black),
    },
    {
      'title': 'پروفایل',
      'icon': Icons.person,
      'page': Container(color: Colors.blue),
    },
  ];
  int _navbarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _navbarIndex == 0 ? null : AppBar(),
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: TextStyle(),
        selectedLabelStyle: TextStyle(),
        selectedIconTheme: IconThemeData(color: Colors.red),
        backgroundColor: Colors.green,
        items: _navbarItems
            .map(
              (e) => BottomNavigationBarItem(
                backgroundColor: Colors.amberAccent,
                icon: Icon(
                  e['icon'],
                ),
                label: e['title'],
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
