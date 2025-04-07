import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  Map<String, dynamic>? userData;
  String? accessToken;
  String? refreshToken;

  void setUserData(Map<String, dynamic> userData, String accessToken, String refreshToken) {
    this.userData = userData;
    this.accessToken = accessToken;
    this.refreshToken = refreshToken;
    notifyListeners();
  }

  void clearUserData() {
    userData = null;
    accessToken = null;
    refreshToken = null;
    notifyListeners();
  }
}
