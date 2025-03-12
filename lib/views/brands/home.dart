// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:hemantenterprises/routes/app_routes.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemantenterprises/constants/colorconstants.dart';
import 'package:hemantenterprises/constants/imageconstants.dart';
import 'package:hemantenterprises/constants/searchfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> brandsList = [];

  @override
  void initState() {
    super.initState();
    fetchBrandData();
  }
  
  Future<void> fetchBrandData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final url = 'https://hemanthapp.whysocial.in/public/brands/getbrandlist';

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print(responseData.toString());

        setState(() {
          brandsList = responseData['banners'] ?? [];
        });
        print('${brandsList.toString()}>>>>>>>>>>>>><<<<<<<<<<<<<');
      } else {
        Fluttertoast.showToast(msg: "Data not found");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
    }
  }

  final String imagebaseurl =
      'https://hemanthapp.whysocial.in/public/uploads/brands/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Ensures Stack covers the full screen
        children: [
          // Background image
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Imageconstants.background),
                  fit:
                      BoxFit.cover, // Ensures the image fully covers the screen
                  opacity: 0.2,
                ),
              ),
            ),
          ),
          // Main content
          SingleChildScrollView(
            child: Column(
              children: [
                // Reusable Custom AppBar
                CustomAppBar(
                  hintText: "Search",
                  onSearchTap: () {
                    // Define action when search bar is tapped
                  },
                ),
                SizedBox(height: 5.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "All Brands",
                        style: GoogleFonts.instrumentSans(
                          fontSize: 14,
                          color: Colorconstants.darkBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: brandsList.isEmpty
                          ? Center(
                              child:
                                  CircularProgressIndicator()) // Show loading indicator
                          : LayoutBuilder(
                              builder: (context, constraints) {
                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                  ),
                                  itemCount: brandsList.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        print('Brand tapped: ${brandsList[index]['brand_name']}');
                                        Get.toNamed(AppRoutes.category);
                                      },
                                      child: Container(
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: Colorconstants.white,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Transform.scale(
                                          scale: 0.5,
                                          child: Image.network(
                                            '${imagebaseurl}${brandsList[index]['brand_img']}',
                                            height: 5,
                                            width: 5,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Icon(Icons.broken_image,
                                                        size: 50),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
