import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _userUid = '';
  String _userIdentifier = '';

  String get userUid => _userUid;
  String get userIdentifier => _userIdentifier;

  void setUserDetails(String uid, String identifier) {
    _userUid = uid;
    _userIdentifier = identifier;
    notifyListeners(); // Notify listeners when data is updated
  }
}
