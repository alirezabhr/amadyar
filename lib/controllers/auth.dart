import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import '../../routes.dart';

import '../models/user.dart';
import '../models/shared_preferences_keys.dart';

String serverBaseAPI = 'http://10.0.2.2:8000';

class Auth {
  static var dio = Dio();

  Future<String?> token = getToken();

  static Future<User> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return User(
      firstname: prefs.getString(SharedPreferencesKeys.firstname),
      lastname: prefs.getString(SharedPreferencesKeys.lastname),
      phoneNumber: prefs.getString(SharedPreferencesKeys.phoneNumber),
      company: prefs.getString(SharedPreferencesKeys.company),
      token: prefs.getString(SharedPreferencesKeys.token),
    );
  }

  static Future<void> saveUserDataInSharedPreference(Map data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String firstname = data['first_name'];
    String lastname = data['last_name'];
    String company = data['company'];
    String token = data['token'];

    prefs.setString(SharedPreferencesKeys.firstname, firstname);
    prefs.setString(SharedPreferencesKeys.lastname, lastname);
    prefs.setString(SharedPreferencesKeys.company, company);
    prefs.setString(SharedPreferencesKeys.token, token);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPreferencesKeys.token);
  }

  static Future<bool> isLoggedIn() async {
    String? token = await Auth.getToken();
    return token != null;
  }

  static Future<void> phoneNumberExists(
      String phoneNumber, BuildContext context) async {

    var url = '$serverBaseAPI/accounts/phone_number/';
    var response = await dio.post(
      url,
      data: {'phone_number': '+98$phoneNumber'},
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPreferencesKeys.phoneNumber, phoneNumber);
    bool exists = response.data['user_exists'];

    Navigator.pushReplacementNamed(context, PageRoutes.otpScreen,
        arguments: {'userExists': exists});
  }

  static Future<void> checkOtp(BuildContext context,
      {required String otp}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var phoneNumber = prefs.getString(SharedPreferencesKeys.phoneNumber);

    var url = '$serverBaseAPI/accounts/otp_check/';
    await dio.post(url, data: {
      'phone_number': '+98$phoneNumber',
      'otp': otp,
    });

    Navigator.pushReplacementNamed(context, PageRoutes.signUpScreen);
  }

  static Future<void> login(BuildContext context, String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var phoneNumber = prefs.getString(SharedPreferencesKeys.phoneNumber);

    var url = '$serverBaseAPI/accounts/login/';
    var response = await dio.post(
      url,
      data: {'phone_number': '+98$phoneNumber', 'otp': code},
    );

    await saveUserDataInSharedPreference(response.data);
    Navigator.pushReplacementNamed(context, PageRoutes.mainPage);
  }

  static Future<void> signup(BuildContext context,
      {required String fistName,
      required String lastName,
      required String companyCode}) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var phoneNumber = prefs.getString(SharedPreferencesKeys.phoneNumber);

    var url = '$serverBaseAPI/accounts/signup/';
    var response = await dio.post(url, data: {
      'phone_number': '+98$phoneNumber',
      'first_name': fistName,
      'last_name': lastName,
      'company_code': companyCode
    });

    await saveUserDataInSharedPreference(response.data);
    Navigator.pushReplacementNamed(context, PageRoutes.mainPage);
  }

  static void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(SharedPreferencesKeys.phoneNumber);
    prefs.remove(SharedPreferencesKeys.firstname);
    prefs.remove(SharedPreferencesKeys.lastname);
    prefs.remove(SharedPreferencesKeys.token);
    prefs.remove(SharedPreferencesKeys.company);
  }
}
