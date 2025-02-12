// ignore_for_file: deprecated_member_use, depend_on_referenced_packages, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hemantenterprises/routes/app_routes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:hemantenterprises/constants/colorconstants.dart';
import 'package:hemantenterprises/constants/imageconstants.dart';
import 'package:hemantenterprises/constants/searchfield.dart';

class ListingPageScreen extends StatefulWidget {
  const ListingPageScreen({super.key});

  @override
  State<ListingPageScreen> createState() => _ListingPageScreenState();
}

class _ListingPageScreenState extends State<ListingPageScreen> {
  String? brandImagePath;
  String? productName;
  String? categoryName;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    brandImagePath = args?['brandImage'];
    productName = args?['product'];
    categoryName = args?['category'];
  }

  Future<File?> downloadFile(String url, String filename) async {
    try {
      final response = await http.get(Uri.parse(url));
      final dir = await getApplicationDocumentsDirectory();
      final file = File("${dir.path}/$filename");

      await file.writeAsBytes(response.bodyBytes);
      return file;
    } catch (e) {
      print("Error downloading file: $e");
      return null;
    }
  }

  void openPDF() async {
    String pdfUrl = "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";
    File? file = await downloadFile(pdfUrl, "sample.pdf");

    if (file != null) {
      Get.to(() => Scaffold(
            appBar: AppBar(title: Text("Technical Drawing", style: GoogleFonts.instrumentSans(color: Colorconstants.darkBlack, fontSize: 18),)),
            body: PDFView(filePath: file.path),
          ));
    } else {
      print("Failed to load PDF");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
          Column(
            children: [
              CustomAppBar(
                hintText: "Search",
                onSearchTap: () {},
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (brandImagePath != null)
                            Container(
                              decoration: BoxDecoration(
                                color: Colorconstants.white,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colorconstants.brandLogoCircle, width: 1.0),
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
                                  text: productName ?? "Category",
                                  style: GoogleFonts.instrumentSans(
                                    fontSize: 14.sp,
                                    color: Colorconstants.brandLogoCircle,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: ' / ',
                                  style: GoogleFonts.instrumentSans(
                                    fontSize: 14.sp,
                                    color: Colorconstants.brandLogoCircle,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: categoryName ?? "Subcategory",
                                  style: GoogleFonts.instrumentSans(
                                    fontSize: 14.sp,
                                    color: Colorconstants.darkBlack,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
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
                      const SizedBox(height: 16),
                      CarouselSlider(
                        items: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Image.asset(
                              Imageconstants.listingPageImage,
                              fit: BoxFit.cover,
                              height: 180,
                              width: double.infinity,
                            ),
                          ),
                        ],
                        options: CarouselOptions(
                          height: 200.0,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 0.8,
                          aspectRatio: 16 / 9,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "HSN: 848180",
                        style: GoogleFonts.instrumentSans(fontSize: 10, color: Colorconstants.darkBlack),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Lineare 1-Handle Basin Mixer without Pop-Up, XL Size",
                        style: GoogleFonts.instrumentSans(fontSize: 12, fontWeight: FontWeight.bold, color: Colorconstants.darkBlack),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                'MRP',
                                style: GoogleFonts.instrumentSans(fontSize: 12, color: Colorconstants.darkBlack, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          SizedBox(width: 10),
                          Text(
                            "₹10,500*",
                            style: GoogleFonts.instrumentSans(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        child: Stack(
                          children: [
                            Container(color: Colors.black.withOpacity(0.3)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Elegance and water-saving performance – the GROHE Lineare single-lever basin mixer with extra high spout!",
                                style: GoogleFonts.instrumentSans(fontSize: 12, color: const Color(0xFF010101)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            "Technical Drawing:",
                            style: GoogleFonts.instrumentSans(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: openPDF,
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "View",
                                  style: GoogleFonts.instrumentSans(color: Colors.black, fontSize: 12, fontStyle: FontStyle.normal),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.picture_as_pdf, color: Colors.red),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Divider(color: Colorconstants.brandLogoCircle, thickness: 1, height: 1),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Get.offNamed(AppRoutes.quote);
                        },
                        child: Text(
                          'Add to Quote',
                          style: GoogleFonts.instrumentSans(color: Color(0xFF0548A0), fontSize: 12, fontStyle: FontStyle.normal),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
