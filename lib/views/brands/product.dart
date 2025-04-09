// ignore_for_file: deprecated_member_use, avoid_print, use_build_context_synchronously, unnecessary_null_comparison

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemantenterprises/constants/apiconstants.dart';
import 'package:hemantenterprises/constants/colorconstants.dart';
import 'package:hemantenterprises/constants/imageconstants.dart';
import 'package:hemantenterprises/constants/searchfield.dart';
import 'package:hemantenterprises/providers/brandlistprovider.dart';
import 'package:hemantenterprises/providers/categoriesprovider.dart';
import 'package:hemantenterprises/providers/productprovider.dart';
import 'package:hemantenterprises/providers/subcategories.dart';
import 'package:hemantenterprises/routes/app_routes.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  List<dynamic> productList = [];

  // ProductListModel? productListModel;
  String? subcatnameindex;
  String? subCatIdindex;
  String? subcatimageindex;

  @override
  void initState() {
    super.initState();

    fetchProductData();
  }

  Future<void> fetchProductData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final subCatId =
        Provider.of<SubCategoryProvider>(context, listen: false).catId;
    final subcatimage =
        Provider.of<SubCategoryProvider>(context, listen: false).catImage;
    final subcatname =
        Provider.of<SubCategoryProvider>(context, listen: false).catName;

    if (subCatId == null && subcatimage == null && subcatname == null) {
      Fluttertoast.showToast(msg: "SubCat ID is missing");
      print('SubCat ID is null');
      return;
    }
    print(subCatId);
    print(subcatimage);
    print(subcatname);
    setState(() {
      subcatnameindex = subcatname;
      subCatIdindex = subCatId;
      subcatimageindex = subcatimage;
    });

    final String apiUrl = '${ApiConstants.baseUrl}${ApiConstants.prodList}';

    print('Fetching categories from: $apiUrl');
    print('Access Token: $token');

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      print('Response Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print(responseData['allproducts']);

        setState(() {
          productList = responseData['allproducts'];
        });
      } else {
        Fluttertoast.showToast(msg: "Data not found");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
      print('Exception caught: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final brandsProvider = Provider.of<BrandsProvider>(context);
    final categoriesProvider = Provider.of<Categoriesprovider>(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image that spans the entire screen
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
                CustomAppBar(
                  hintText: "Search",
                  onSearchTap: () {},
                ),
                const SizedBox(height: 16),
                // Page title
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        if (brandsProvider.brandImg != null)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              '${ApiConstants.brandImgBaseUrl}${brandsProvider.brandImg}',
                              height: 30,
                              width: 30,
                              fit: BoxFit.contain,
                            ),
                          ),
                        const SizedBox(width: 8),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: categoriesProvider.catName ??
                                    "Category", // Product name
                                style: GoogleFonts.instrumentSans(
                                  fontSize: 14.sp,
                                  color: Colorconstants
                                      .brandLogoCircle, // Change color for product name
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: ' / ', // Separator
                                style: GoogleFonts.instrumentSans(
                                  fontSize: 14.sp,
                                  color: Colorconstants
                                      .brandLogoCircle, // Change color for separator
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: subcatnameindex ??
                                    "Subcategory", // Subcategory name
                                style: GoogleFonts.instrumentSans(
                                  fontSize: 14.sp,
                                  color: Colorconstants
                                      .darkBlack, // Change color for subcategory
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Get.back(); // Navigate back to Brand Details Screen
                          },
                          child: Text(
                            'Back',
                            style: GoogleFonts.nunitoSans(
                              color: Color(0xFF0548A0),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 1.h),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: productList.isEmpty
                      ? Center(
                          child: Text("No Products found"),
                        )
                      : GridView.builder(
                          //  padding: const EdgeInsets.only(top: 10),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 5,
                                  childAspectRatio: 0.9),
                          itemCount: productList.length,
                          shrinkWrap:
                              true, // Makes GridView take only as much space as needed
                          physics:
                              const NeverScrollableScrollPhysics(), // Prevents inner scrolling
                          itemBuilder: (context, index) {
                            final product = productList[index];

                            return GestureDetector(
                              onTap: () {
                                final productProvider =
                                    Provider.of<ProductProvider>(context,
                                        listen: false);

                                productProvider.setProductData({
                                  'product_code': product['product_code'],
                                  'product_description':
                                      product['product_description'],
                                  'product_image1': product['product_image1'],
                                  'product_image2': product['product_image2'],
                                  'product_image3': product['product_image3'],
                                  'product_document':
                                      product['product_document'],
                                  'product_price': product['product_price'],
                                });

                                Get.toNamed(AppRoutes.listingPage);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: 100,
                                      color: Colors.white,
                                      child: Image.network(
                                        "${ApiConstants.prodBaseUrl}${product['product_image1']}",
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'HSN: ${product['product_code']}',
                                    style: GoogleFonts.instrumentSans(
                                      fontSize: 10,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  const SizedBox(height: 8),
                                  Expanded(
                                    child: Text(
                                      product['product_name'] ?? "",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: GoogleFonts.instrumentSans(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
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
