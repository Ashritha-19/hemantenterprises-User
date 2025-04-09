import 'package:flutter/material.dart';

class SubCategoryProvider with ChangeNotifier {
  String _catId = '';
  String _catImage = '';
  String _catName = '';

  // Getters
  String get catId => _catId;
  String get catImage => _catImage;
  String get catName => _catName;

  // Setters
  void setSubCategoryValues(String id, String image, String name) {
    _catId = id;
    _catImage = image;
    _catName = name;
    notifyListeners();
  }

  // Optional: Clear values
  void clearSubCategory() {
    _catId = '';
    _catImage = '';
    _catName = '';
    notifyListeners();
  }
}
