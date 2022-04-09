
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth.dart';

class AuthProvider{

  String? authToken;

  AuthProvider(this.authToken);
  

}