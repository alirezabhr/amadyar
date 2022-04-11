import 'package:flutter/cupertino.dart';

import '../controllers/auth.dart';

class User with ChangeNotifier {
  String? firstname;
  String? lastname;
  String? phoneNumber;
  String? company;
  String? token;

  User({
    this.firstname,
    this.lastname,
    this.phoneNumber,
    this.company,
    this.token,
  });

  Future<void> updateUser() async {
    var user = await Auth.getUser();
    firstname = user.firstname;
    lastname = user.lastname;
    phoneNumber = user.phoneNumber;
    company = user.company;
    token = user.token;
    notifyListeners();
  }
}
