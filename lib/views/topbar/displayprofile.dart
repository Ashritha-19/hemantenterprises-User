import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemantenterprises/constants/colorconstants.dart';
import 'package:hemantenterprises/constants/imageconstants.dart';
import 'package:hemantenterprises/constants/searchfield.dart';
import 'package:hemantenterprises/routes/app_routes.dart';

class DisplayProfile extends StatefulWidget {
  const DisplayProfile({super.key});

  @override
  State<DisplayProfile> createState() => _DisplayProfileState();
}

class _DisplayProfileState extends State<DisplayProfile> {
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
                onSearchTap: () {
                  // Define action when search bar is tapped
                },
              ),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Profile',
                              style: GoogleFonts.instrumentSans(
                                  color: Colorconstants.darkBlack,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800),
                            ),
                            Spacer(),
                            // SizedBox(width: 10),

                            ElevatedButton(
                              onPressed: () {
                                Get.toNamed(AppRoutes.editProfile);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colorconstants
                                    .primaryColor, // Set background color
                              ),
                              child: Text(
                                'Edit Profile',
                                style: GoogleFonts.nunitoSans(
                                  color: Colorconstants.white, // Text color
                                  fontSize: 12,
                                ),
                              ),
                            )
                          ],
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
                        ),
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                                12.0), // Adds some spacing inside the Card
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize
                                  .min, // Ensures the Card wraps its content
                              children: [
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  "Name",
                                  style: GoogleFonts.instrumentSans(
                                    color: Colorconstants.darkBlack,
                                    fontSize: 14,
                                  ),
                                ),
                                Divider(
                                    thickness: 1,
                                    height: 1,
                                    color: Colorconstants.brandLogoCircle),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  "Email ID",
                                  style: GoogleFonts.instrumentSans(
                                    color: Colorconstants.darkBlack,
                                    fontSize: 14,
                                  ),
                                ),
                                Divider(
                                    thickness: 1,
                                    height: 1,
                                    color: Colorconstants.brandLogoCircle),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  "Phone Number",
                                  style: GoogleFonts.instrumentSans(
                                    color: Colorconstants.darkBlack,
                                    fontSize: 14,
                                  ),
                                ),
                                Divider(
                                    thickness: 1,
                                    height: 1,
                                    color: Colorconstants.brandLogoCircle),
                                SizedBox(
                                  height: 2.h,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
