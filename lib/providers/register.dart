import 'package:flutter/material.dart';

class CreateAccountProvider with ChangeNotifier {
  String _fullName = " ";
  String _email = " ";

  String get fullName => _fullName;
  String get email => _email;

  void setAccountData(String fullName, String email){
    _fullName = fullName;
    _email = email;
    
    notifyListeners();
  }
}
