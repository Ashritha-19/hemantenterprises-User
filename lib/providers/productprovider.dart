import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  Map<String, dynamic> _productData = {};

  Map<String, dynamic> get productData => _productData;

  void setProductData(Map<String, dynamic> data) {
    _productData = data;
    notifyListeners();
  }

  // Optional: individual getters if needed
  String get productCode => _productData['product_code'] ?? '';
  String get productDescription => _productData['product_description'] ?? '';
  String get productImage1 => _productData['product_image1'] ?? '';
  String get productImage2 => _productData['product_image2'] ?? '';
  String get productImage3 => _productData['product_image3'] ?? '';
  String get productDocument => _productData['product_document'] ?? '';
  double get productAmt => double.tryParse("product_price") ?? 0.0;
  String get productname => _productData['product_name'] ?? "";


}
