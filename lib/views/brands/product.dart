// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemantenterprises/constants/colorconstants.dart';
import 'package:hemantenterprises/constants/imageconstants.dart';
import 'package:hemantenterprises/constants/searchfield.dart';
import 'package:hemantenterprises/routes/app_routes.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? brandImagePath;
  String? productName;
  String? categoryName;



 final List<String> subCategoryImages = [
  Imageconstants.hsn1,
  Imageconstants.hsn2,
  Imageconstants.hsn3,
  Imageconstants.hsn4,
  Imageconstants.hsn5,
  Imageconstants.hsn6,
  Imageconstants.hsn7,
  Imageconstants.hsn8,
  Imageconstants.hsn9,
  Imageconstants.hsn10,
  Imageconstants.hsn11,
  Imageconstants.hsn12,
];




 final List<String> subCategoryNames = [
  "HSN: 848180",
  "HSN: 848180",
  "HSN: 848180",
  "HSN: 848180",
  "HSN: 848180",
  "HSN: 848180",
  "HSN: 848180",
  "HSN: 848180",
  "HSN: 848180",
  "HSN: 848180",
  "HSN: 848180",
  "HSN: 848180",

];

final List<String> subCategoryDetails = [
  "Lineare 1- Handle Basin Mixer without Pop-Up XL Size",
  "Lineare 2-Hole, 1-Handle Wall-Mount Basin Mixer, L Size",
  "Lineare 1-Handle Basin Mixer with Pop-Up, XS Size",
  "Lineare 1-Handle Basin Mixer with Pop-Up, S Size",
  "Lineare OHM vessel fitting basin",
  "Lineare 2-Hole, 1-Handle Wall-Mount Basin Mixer, L Size",
  "Lineare 1-Handle Basin Mixer with Pop-Up, XS Size",
  "Lineare 1-Handle basin Mixer with Pop-Up, S Size",
  "Lineare OHM trimset basin 2-h wall",
  "Lineare 1-Handle Basin Mixer with Push-Open, S Size",
  "Lineare 2-Hole, 1-Handle Wall-Mount Basin Mixer, M Size",
  "Lineare OHM trimset basin 2-h wall",
];

@override
void initState() {
  super.initState();
  final args = Get.arguments as Map<String, dynamic>?;

 
  brandImagePath = args?['brandImage']; 
  productName = args?['product'];// Brand logo passed dynamically
  categoryName = args?['category']; // Category name passed dynamically
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                  onSearchTap: (
                    
                  ) {
                    
                  },
                ),
                const SizedBox(height: 16),
                // Page title
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                       children: [
                        if (brandImagePath != null)
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
                            child: Image.asset(
                              brandImagePath!,
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
                              text: productName ?? "Category", // Product name
                              style: GoogleFonts.instrumentSans(
                              fontSize: 14.sp,
                              color: Colorconstants.brandLogoCircle, // Change color for product name
                              fontWeight: FontWeight.w500,
                                    ),
                                  ),
                        TextSpan(
                              text: ' / ', // Separator
                              style: GoogleFonts.instrumentSans(
                              fontSize: 14.sp,
                              color: Colorconstants.brandLogoCircle, // Change color for separator
                              fontWeight: FontWeight.w500,
                                  ),
                                ),
                        TextSpan(
                              text: categoryName ?? "Subcategory", // Subcategory name
                              style: GoogleFonts.instrumentSans(
                              fontSize: 14.sp,
                              color: Colorconstants.darkBlack, // Change color for subcategory
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
                
                     /*     SizedBox(
                  height: 1.h,
                ), */
                // Brands grid
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.builder(
                  //  padding: const EdgeInsets.only(top: 10),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 30,
                      
                      
                    ),
                    itemCount: subCategoryImages.length,
                    shrinkWrap: true, // Makes GridView take only as much space as needed
                    physics: const NeverScrollableScrollPhysics(), // Prevents inner scrolling
                    itemBuilder: (context, index) {
                      final brand = subCategoryImages[index];
                      final brandName = subCategoryNames[index];
                      final brandDetails = subCategoryDetails[index];
                      return GestureDetector(
                          onTap: () {
                          // Navigate to Category Screen with selected data
                          Get.toNamed(
                            AppRoutes.listingPage,
                            arguments: {
                              'brandImage': brandImagePath,
                              'product': productName,
                              'category':categoryName,
                            },
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                 color: Colors.white,
                                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                 child: Image.asset(
                                 brand,
                                 fit: BoxFit.contain,
                                 height: 80, 
                                 width: 140,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              brandName,
                              style: GoogleFonts.instrumentSans(
                                fontSize: 10,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.start,
                            ),
                        
                            const SizedBox(height: 8),
                             Text(
                              brandDetails,
                              style: GoogleFonts.instrumentSans(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.start,
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
