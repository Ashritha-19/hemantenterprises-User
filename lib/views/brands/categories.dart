// ignore_for_file: file_names, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemantenterprises/constants/colorconstants.dart';
import 'package:hemantenterprises/constants/imageconstants.dart';
import 'package:hemantenterprises/constants/searchfield.dart';
import 'package:hemantenterprises/routes/app_routes.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String? imagePath;
  String? brandName;

   List<dynamic> categories = [];
   List<String> categoryNames = [];

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    imagePath = args?['image'];
    brandName = args?['name'];
    fetchCategoryData();
  }

  //  @override
  // void initState() {
  //   super.initState();
  //   fetchBrandData();
  // }
  
  Future<void> fetchCategoryData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final url = 'https://hemanthapp.whysocial.in/public/user/getcategorytype';

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
          categories = responseData['banners'] ?? [];
          categoryNames = responseData['banners'] ?? [];
        });
        print('${categories.toString()}>>>>>>>>>>>>><<<<<<<<<<<<<');
        print('$categoryNames>>>>>>>>>>>>');
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
        children: [
          // Background image
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Imageconstants.background),
                  fit: BoxFit.cover,
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
                SizedBox(height: 2.h),
                // Page title
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (imagePath != null)
                              Container(
                                decoration: BoxDecoration(
                                  color: Colorconstants.white,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: Colorconstants.brandLogoCircle,
                                    width: 1.0,
                                  ),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  imagePath!,
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            const SizedBox(width: 10),
                            Text(
                              brandName ?? "Brand",
                              style: GoogleFonts.instrumentSans(
                                fontSize: 14,
                                color: Colorconstants.darkBlack,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'Back',
                                style: GoogleFonts.nunitoSans(
                                  color: Colorconstants.primaryColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
                          "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
                          "when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                          style: GoogleFonts.instrumentSans(
                            fontSize: 12,
                            color: Colorconstants.darkBlack,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Divider(
                          thickness: 1,
                          height: 1,
                          color: Colorconstants.brandLogoCircle,
                        ),
                        SizedBox(
                          height: 2.h,
                        )
                      ],
                    ),
                  ),
                ),
                // Products grid
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: categories.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final categoryType = categoryNames[index];
                      return GestureDetector(
                        onTap: () {
                          // Navigate to Category Screen with selected data
                          Get.toNamed(
                            AppRoutes.category,
                            arguments: {
                              'brandImage': imagePath,
                              // 'brandName': brandName,
                              'categoryName': categoryType,
                            },
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                category,
                                fit: BoxFit.contain,
                                height: 80,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              categoryType,
                              style: GoogleFonts.instrumentSans(
                                fontSize: 12,
                                color: Colorconstants.darkBlack,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
