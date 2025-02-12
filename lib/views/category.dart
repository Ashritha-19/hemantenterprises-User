import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemantenterprises/constants/colorconstants.dart';
import 'package:hemantenterprises/constants/imageconstants.dart';
import 'package:hemantenterprises/constants/searchfield.dart';
import 'package:hemantenterprises/routes/app_routes.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String? brandImagePath;
  String? productName; // Dynamic product name to display in place of "Brand".

  final List<String> categories = [
    Imageconstants.alira,
    Imageconstants.allure,
    Imageconstants.arabesque,
    Imageconstants.aria,
    Imageconstants.atrio,
    Imageconstants.bauclassic,
    Imageconstants.baucontemporary,
    Imageconstants.baumetric,
    Imageconstants.chiara,
    Imageconstants.concetto,
    Imageconstants.costa,
    Imageconstants.essence,
    Imageconstants.eurocube,
    Imageconstants.eurodisc,
    Imageconstants.europlus,
    Imageconstants.eurosmart,
    Imageconstants.grandera,
    Imageconstants.grohefdigital,
    Imageconstants.groheondus,
    Imageconstants.kensington,
    Imageconstants.lineare,
    Imageconstants.quadra,
    Imageconstants.tenso,
    Imageconstants.veris,
  ];

  final List<String> categoryNames = [
    "Alira",
    "Allure",
    "Arabesque",
    "Aria",
    "Atrio",
    "Bau Classic",
    "Bau Contemporary",
    "Bau Metric",
    "Chiara",
    "Concetto",
    "Costa",
    "Essence",
    "Eurocube",
    "Eurodisc",
    "Europlus",
    "Eurosmart",
    "Grandera",
    "Grohe F-Digital",
    "Grohe Ondus",
    "Kensington",
    "Lineare",
    "Quadra",
    "Tenso",
    "Veris",
  ];

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    brandImagePath = args?['brandImage']; // Brand logo passed dynamically.
    productName = args?['categoryName']; // Product name passed dynamically.
  }

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
                CustomAppBar(
                  hintText: "Search",
                  onSearchTap: () {
                    // Define action for search
                  },
                ),
                 SizedBox(height: 2.h),
                // Page title with brand logo and product name
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        if (brandImagePath != null)
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
                              brandImagePath!,
                              height: 30,
                              width: 30,
                              fit: BoxFit.contain,
                            ),
                          ),
                        const SizedBox(width: 8),
                        Text(
                          productName ?? "Product", // Display product name dynamically.
                          style: GoogleFonts.instrumentSans(
                            fontSize: 14,
                            color: Colorconstants.darkBlack,
                            fontWeight: FontWeight.bold,
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
                              color: Colorconstants.primaryColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Categories grid
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: categories.length,
                    shrinkWrap: true, // GridView will take only as much space as needed
                    physics: const NeverScrollableScrollPhysics(), // Prevent inner scrolling
                    itemBuilder: (context, index) {
                      final categoryImage = categories[index];
                      final categoryName = categoryNames[index];
                      return GestureDetector(
                         onTap: () {
                          // Navigate to Category Screen with selected data
                          Get.toNamed(
                            AppRoutes.subCategory,
                            arguments: {
                              'brandImage': brandImagePath,
                              'product': productName,
                              'category':categoryName,
                            },
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                categoryImage,
                                fit: BoxFit.contain,
                                height: 80,
                              
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              categoryName,
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
