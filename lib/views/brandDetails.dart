// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemantenterprises/constants/colorconstants.dart';
import 'package:hemantenterprises/constants/imageconstants.dart';
import 'package:hemantenterprises/constants/searchfield.dart';
import 'package:hemantenterprises/routes/app_routes.dart';

class BrandDetailsScreen extends StatefulWidget {
  const BrandDetailsScreen({super.key});

  @override
  State<BrandDetailsScreen> createState() => _BrandDetailsScreenState();
}

class _BrandDetailsScreenState extends State<BrandDetailsScreen> {
  String? imagePath;
  String? brandName;

  final List<String> products = [
    Imageconstants.accessories,
    Imageconstants.anglevalve,
    Imageconstants.basinmixer,
    Imageconstants.basinpillartap,
    Imageconstants.bathmixer,
    Imageconstants.bathspout,
    Imageconstants.bathtub,
    Imageconstants.bathtubfilter,
    Imageconstants.handshower,
    Imageconstants.seatcover,
    Imageconstants.showerrail,
    Imageconstants.sinkmixer,
    Imageconstants.sinktap,
    Imageconstants.thermostat,
    Imageconstants.washbasin,
  ];

  final List<String> productsNames = [
    "Accessories",
    "Angle Valve",
    "Basin Mixer",
    "Basin Pillar Tap",
    "Bath Mixer",
    "Bath Spout",
    "Bathtub",
    "Bathtub Filter",
    "Hand Shower",
    "Seat Cover",
    "Shower Rail",
    "Sink Mixer",
    "Sink Tap",
    "Thermostat",
    "Wash Basin",
  ];

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    imagePath = args?['image'];
    brandName = args?['name'];
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
                    itemCount: products.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      final productName = productsNames[index];
                      return GestureDetector(
                        onTap: () {
                          // Navigate to Category Screen with selected data
                          Get.toNamed(
                            AppRoutes.category,
                            arguments: {
                              'brandImage': imagePath,
                              // 'brandName': brandName,
                              'categoryName': productName,
                            },
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                product,
                                fit: BoxFit.contain,
                                height: 80,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              productName,
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
