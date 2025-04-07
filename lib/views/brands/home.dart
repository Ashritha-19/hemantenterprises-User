// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print, unused_local_variable, use_build_context_synchronously

import 'dart:convert';
import 'package:get/get.dart';
import 'package:hemantenterprises/constants/apiconstants.dart';
import 'package:hemantenterprises/models/branslist.dart';
import 'package:hemantenterprises/providers/brandlistprovider.dart';
import 'package:hemantenterprises/routes/app_routes.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemantenterprises/constants/colorconstants.dart';
import 'package:hemantenterprises/constants/imageconstants.dart';
import 'package:hemantenterprises/constants/searchfield.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Banners>? _brandsList = [];
  BrandsListModel? brandsListModel;

  @override
  void initState() {
    super.initState();
    fetchBrandData();
  }

  Future<void> fetchBrandData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    // final refreshToken = prefs.getString('refresh_token');

    if (token == null) {
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

        setState(() {
          _brandsList = brandsListModel?.banners ?? []; // Ensure it's not null
        });

        // Store data in Provider
      } else {
        Fluttertoast.showToast(msg: "Data not found");
      }
    } catch (e) {
      print("Error fetching brand data: ${e.toString()}");
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
    }
  }

  final String brandImgUrl = ApiConstants.brandImgBaseUrl;

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
                      child: _brandsList == null
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
                                  itemCount: _brandsList!.length,
                                  itemBuilder: (context, index) {
                                    Banners brand = _brandsList![index];
                                    return GestureDetector(
                                      onTap: () {
                                        final brandsProvider =
                                            Provider.of<BrandsProvider>(context,
                                                listen: false);
                                        brandsProvider.setBrandDetails(
                                            brand.brandId.toString(),
                                            brand.brandImg.toString(),
                                            brand.brandName.toString(),
                                            brand.brandDescription.toString());

                                        Get.toNamed(AppRoutes.category);
                                        
                                        print('Brand tapped: ${brand.brandName}');
                                        print(brand.brandId);
                                        print(brand.brandImg);
                                        print(brand.brandName);
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
                                            '${brandImgUrl}${brand.brandImg}',
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
