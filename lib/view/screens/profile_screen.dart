import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  String fullname(String? firstname, String? lastname){
    return firstname != null && lastname != null ? firstname + lastname : "";
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    final user = Provider.of<User>(context);
    const TextStyle style = TextStyle(fontSize: 20);

    return Scaffold(
      body: Center(
        child: SizedBox(
      height: deviceSize.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 18.0),
                child: CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage(
                'assets/images/profile.jpg',
            ),
          ),
              ),
              Text(
                fullname(user.firstname, user.lastname),
                textDirection: TextDirection.rtl,
                style: style,
              ),
             Text(
                user.phoneNumber != null ? user.phoneNumber as String : "",
                textDirection: TextDirection.rtl,
                style: style,
              ),
             Text(
                user.company != null ? user.company as String : "",
                textDirection: TextDirection.rtl,
                style: style,
              ),
             
            ],
          ),
          SizedBox(
            width: (deviceSize.width * 2) / 5,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "تماس با پشتیبانی",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
        ),
      ),
    );
  }
}
