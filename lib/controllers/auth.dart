import 'dart:convert';

import 'package:amadyar/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

String serverBaseAPI = 'http://10.0.2.2:8000';

class Auth{

  Future<String?> token = getToken();

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
    var url = Uri.parse('$serverBaseAPI/accounts/phone_number/');
    var response = await http.post(url, body: {'phone_number': '+98$phoneNumber'});
    Map<String, Object> parsedData = jsonDecode(response.body);
    if(!parsedData.containsKey('user_exists')){
      //add Toast
      return false;
    }
    bool exists = jsonDecode(response.body)['user_exists'];
    //TODO: add state handling => phone num is valid or not and changing pages!
    if(exists){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('phone_number', phoneNumber);
      return true;
    }
    Navigator.pushReplacementNamed(context, PageRoutes.otpScreen);
    return false;
  }

  static Future<bool> login(String code, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var phoneNumber = prefs.getString('phone_number'); 
    var url = Uri.parse('$serverBaseAPI/accounts/login/');
    var response = await http.post(url, body: {'phone_number': '+98$phoneNumber', 'otp': code});
    var parsedData = json.decode(response.body);
    try{
      String access = parsedData['access'];
      String refresh = parsedData['refresh'];
      prefs.setString('access', access);
      prefs.setString('refresh', refresh);
      Navigator.pushReplacementNamed(context, PageRoutes.mainPage); 
    } catch(e){
      return false;
    }
    return true;
  }

  static Future<bool> signup(String fistName, String lastName, String compayCode) async {
    //api call to server
    return false;
  }

  static void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('phone_number');
    prefs.remove('fist_name');
    prefs.remove('last_name');
    prefs.remove('access');
    prefs.remove('refresh');
    prefs.remove('company');
  }

}