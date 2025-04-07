import 'package:flutter/material.dart';

class BrandsProvider with ChangeNotifier {
  String? brandId;
  String? brandImg;
  String? brandName;
  String? brandDescription;

  void setBrandDetails(String id, String img, String name,String description) {
    brandId = id;
    brandImg = img;
    brandName = name;
    brandDescription = description;
    notifyListeners();
  }
}
