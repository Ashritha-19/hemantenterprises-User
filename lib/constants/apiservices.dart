// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hemantenterprises/constants/apiconstants.dart';
import 'package:hemantenterprises/models/branslist.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class ApiServices {
  
  BrandsListModel? brandsListModel;

  Future<void> fetchBrandData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null ) {
      Fluttertoast.showToast(msg: "Token not found. Please log in again.");
      return;
    }

    String apiUrl = '${ApiConstants.baseUrl}${ApiConstants.brandListUrl}';

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    try {
      print("Fetching brand data from: $apiUrl");
      print("Headers: $headers");

      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        
        brandsListModel = BrandsListModel.fromJson(responseData);

        print("Parsed brands list:");
        brandsListModel?.banners?.forEach((banner) {
          print("Brand ID: ${banner.brandId}, Name: ${banner.brandName}, Image: ${banner.brandImg}");
        });

      } else {
        Fluttertoast.showToast(msg: "Data not found");
      }
    } catch (e) {
      print("Error fetching brand data: ${e.toString()}");
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
    }
  }
}
