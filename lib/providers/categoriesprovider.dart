import 'package:flutter/foundation.dart';

class Categoriesprovider with ChangeNotifier{

 String? catId;
 String? brandImg;
 String? catName;

 void setCatDetails(String id, String img, String name){
    catId = id;
    brandImg = img;
    catName = name;
  
    notifyListeners();
 }
}