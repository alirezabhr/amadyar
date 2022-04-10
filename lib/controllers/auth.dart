import 'dart:convert';

import 'package:amadyar/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../models/user.dart';

String serverBaseAPI = 'http://10.0.2.2:8000';

class Auth{
  
  static var dio = Dio();

  Future<String?> token = getToken();

  static Future<User> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return User(
      firstname: prefs.getString('firstname'),
      lastname: prefs.getString('lastname'),
      phoneNumber: prefs.getString('phoneNumber'),
      company: prefs.getString('company'),
      token: prefs.getString('access'),
    );
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access');
  }

  static Future<bool> isLoggedIn() async {
    String? token = await Auth.getToken();
    return token != null;
  }

  static Future<bool> phoneNumberExists(String phoneNumber, BuildContext context) async {
    //add input validity check! probably to the other side of this code
    var url = '$serverBaseAPI/accounts/phone_number/';
    var response = await dio.post(url, data: {'phone_number': '+98$phoneNumber'});
    Map<String, Object> parsedData = jsonDecode(response.data);
    if(!parsedData.containsKey('user_exists')){
      //add Toast
      return false;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phoneNumber', phoneNumber);
    bool exists = jsonDecode(response.data)['user_exists'];
    Navigator.pushReplacementNamed(context, PageRoutes.otpScreen);
    return true;
  }

  static Future<bool> login(String code, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var phoneNumber = prefs.getString('phone_number'); 
    var url = '$serverBaseAPI/accounts/login/';
    var response = await dio.post(url, data: {'phone_number': '+98$phoneNumber', 'otp': code});
    var parsedData = json.decode(response.data);
    try{
      String firstname = parsedData['first_name'];
      String lastname = parsedData['last_name'];
      String company = parsedData['company'];
      String access = parsedData['access'];
      String refresh = parsedData['refresh'];
      prefs.setString('firstname', firstname);
      prefs.setString('lastname', lastname);
      prefs.setString('company', company);
      prefs.setString('access', access);
      prefs.setString('refresh', refresh);
      Navigator.pushReplacementNamed(context, PageRoutes.mainPage); 
    } catch(e){
      return false;
    }
    return true;
  }

  static Future<bool> signup(BuildContext context, {required String fistName, required String lastName, required String compayCode}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var phoneNumber = prefs.getString('phone_number'); 
    var url = '$serverBaseAPI/accounts/signup/';
    var response = await dio.post(url, data: {'phone_number': phoneNumber, 'first_name': fistName, 'last_name': lastName, 'company_code': compayCode});
    var parsedData = json.decode(response.data);
    if(response.statusCode != 200){
      return false;
    }
    Navigator.pushReplacementNamed(context, PageRoutes.mainPage);
    return true;
  }

  static void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('phoneNumber');
    prefs.remove('fistname');
    prefs.remove('lastname');
    prefs.remove('access');
    prefs.remove('refresh');
    prefs.remove('company');
  }

}