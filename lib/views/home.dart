import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemantenterprises/constants/colorconstants.dart';
import 'package:hemantenterprises/constants/imageconstants.dart';
import 'package:hemantenterprises/constants/searchfield.dart';
import 'package:hemantenterprises/routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> brands = [
    Imageconstants.hindware,
    Imageconstants.jaguar,
    Imageconstants.brizo,
    Imageconstants.queo,
    Imageconstants.franke,
    Imageconstants.grohe,
  ];

  final List<String> brandNames = [
    "Hindware",
    "Jaguar",
    "Brizo",
    "Queo",
    "Franke",
    "Grohe",
  ];

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
          Column(
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
                  // Brands grid
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GridView.builder(
                      padding: const EdgeInsets.only(top: 10),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: brands.length * 3,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final brand = brands[index % brands.length];
                        final brandName = brandNames[index % brandNames.length];
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.brandDetails,
                              arguments: {
                                'image': brand,
                                'name': brandName,
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colorconstants.white,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: Colorconstants.brandLogoCircle,
                                width: 1.0
                              )
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              brand,
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),  
    );
  }
}
