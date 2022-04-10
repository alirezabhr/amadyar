


import 'package:amadyar/controllers/auth.dart';
import 'package:flutter/material.dart';

class User extends ChangeNotifier{

  String? firstname;
  String? lastname;
  String? phoneNumber;
  String? company;
  String? token;


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