// ignore_for_file: file_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemantenterprises/constants/colorconstants.dart';
import 'package:hemantenterprises/constants/imageconstants.dart';
import 'package:hemantenterprises/constants/searchfield.dart';
import 'package:hemantenterprises/models/elevatedbuttonmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _message = TextEditingController();

  void _showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colorconstants.primaryColor,
    textColor: Colorconstants.white,
    fontSize: 14.0,
  );
}

  @override
  Widget build(BuildContext context) {
    final List<String> imageList = [
      Imageconstants.image1,
      Imageconstants.image2,
      Imageconstants.image3,
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
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

          // Main Content wrapped in SingleChildScrollView
          Column(
            children: [
              // Custom App Bar
              CustomAppBar(
                hintText: "Search",
                onSearchTap: () {
                  // Handle search bar tap
                },
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // About Us Title
                        Text(
                          'About Us',
                          style: GoogleFonts.instrumentSans(
                            color: Colorconstants.darkBlack,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2.h),

                        // Carousel Slider
                        CarouselSlider(
                          items: imageList.map((imagePath) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Image.asset(
                                imagePath,
                                fit: BoxFit.cover,
                                width: 350.0,
                              ),
                            );
                          }).toList(),
                          options: CarouselOptions(
                            height: 220.0,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 0.8,
                            aspectRatio: 16 / 9,
                          ),
                        ),
                        SizedBox(height: 2.h),

                        // About Us Description
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
                        SizedBox(height: 2.h),

                        // Contact Information

                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final Uri url =
                                    Uri(scheme: 'tel', path: '+919876543210');
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                } else {
                                  print('Could not launch $url');
                                }
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.phone,
                                      color: Colorconstants.darkBlack),
                                  const SizedBox(width: 5),
                                  Text(
                                    '+91 9876543210',
                                    style: GoogleFonts.instrumentSans(
                                      color: Colorconstants.darkBlack,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 2.w),
                            GestureDetector(
                              onTap: () async {
                                final Uri emailUri = Uri(
                                    scheme: 'mailto',
                                    path: 'info@hemantenterprises.org');
                                if (await canLaunchUrl(emailUri)) {
                                  await launchUrl(emailUri);
                                } else {
                                  print('Could not launch $emailUri');
                                }
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.mail,
                                      color: Colorconstants.darkBlack),
                                  const SizedBox(width: 5),
                                  Text(
                                    'info@hemantenterprises.org',
                                    style: GoogleFonts.instrumentSans(
                                      color: Colorconstants.darkBlack,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 2.h),

                        // Card with "Contact Us" form
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Contact Us',
                                    style: GoogleFonts.instrumentSans(
                                      fontSize: 14,
                                      color: Colorconstants.darkBlack,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),

                                  // Full Name Field with Validation
                                  TextFormField(
                                    controller: _fullName,
                                    decoration: InputDecoration(
                                      hintText: "Full Name",
                                      hintStyle: GoogleFonts.instrumentSans(
                                        color: Colorconstants.brandLogoCircle,
                                        fontSize: 12,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                          color: Colorconstants.brandLogoCircle,
                                          width: 1,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                          color: Colorconstants.brandLogoCircle,
                                          width: 1,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                          color: Colorconstants.brandLogoCircle,
                                          width: 1,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                          width: 1,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                          width: 1,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0,
                                        horizontal: 15.0,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter your full name";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 1.h),

                                  // Email and Phone Fields with Validation
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: _email,
                                          decoration: InputDecoration(
                                            hintText: "Email",
                                            hintStyle:
                                                GoogleFonts.instrumentSans(
                                              color: Colorconstants
                                                  .brandLogoCircle,
                                              fontSize: 12,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: BorderSide(
                                                color: Colorconstants
                                                    .brandLogoCircle,
                                                width: 1,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: BorderSide(
                                                color: Colorconstants
                                                    .brandLogoCircle,
                                                width: 1,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: BorderSide(
                                                color: Colorconstants
                                                    .brandLogoCircle,
                                                width: 1,
                                              ),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 1,
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 1,
                                              ),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              vertical: 10.0,
                                              horizontal: 15.0,
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please enter your email";
                                            } else if (!RegExp(
                                                    r'^[^@]+@[^@]+\.[^@]+')
                                                .hasMatch(value)) {
                                              return "Please enter a valid email address";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 1.h),
                                      Expanded(
                                        child: TextFormField(
                                          keyboardType: TextInputType.phone,
                                          controller: _phone,
                                          decoration: InputDecoration(
                                            hintText: "Phone",
                                            hintStyle:
                                                GoogleFonts.instrumentSans(
                                              color: Colorconstants
                                                  .brandLogoCircle,
                                              fontSize: 12,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: BorderSide(
                                                color: Colorconstants
                                                    .brandLogoCircle,
                                                width: 1,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: BorderSide(
                                                color: Colorconstants
                                                    .brandLogoCircle,
                                                width: 1,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: BorderSide(
                                                color: Colorconstants
                                                    .brandLogoCircle,
                                                width: 1,
                                              ),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 1,
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 1,
                                              ),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              vertical: 10.0,
                                              horizontal: 15.0,
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please enter your phone number";
                                            } else if (value.length != 10) {
                                              return "Please enter a valid 10-digit phone number";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 1.h),

                                  // Message Field with Validation
                                  TextFormField(
                                    controller: _message,
                                    maxLines: 4,
                                    decoration: InputDecoration(
                                      hintText: "Message",
                                      hintStyle: GoogleFonts.instrumentSans(
                                        color: Colorconstants.brandLogoCircle,
                                        fontSize: 12,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        borderSide: BorderSide(
                                          color: Colorconstants.brandLogoCircle,
                                          width: 1,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        borderSide: BorderSide(
                                          color: Colorconstants.brandLogoCircle,
                                          width: 1,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        borderSide: BorderSide(
                                          color: Colorconstants.brandLogoCircle,
                                          width: 1,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                          width: 1,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                          width: 1,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0,
                                        horizontal: 15.0,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter a message";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 2.h),

                                   CustomElevatedButton(
                                    text: "Submit",
                                    textStyle: GoogleFonts.instrumentSans(
                                        color: Colorconstants.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 30) ,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _showToast(
                                            "Form Submitted Successfully");
                                            _fullName.clear();
                                            _phone.clear();
                                            _message.clear();
                                            _email.clear();
                                      } else {
                                        Fluttertoast.showToast(
                                          msg:
                                              "Please fill out the form correctly.",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 14.0,
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
