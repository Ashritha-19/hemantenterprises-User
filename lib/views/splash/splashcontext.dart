// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemantenterprises/constants/imageconstants.dart';
import 'package:hemantenterprises/routes/app_routes.dart';

class SplashContext extends StatefulWidget {
  const SplashContext({super.key});

  @override
  _SplashContextState createState() => _SplashContextState();
}

class _SplashContextState extends State<SplashContext> {
  int selectedIndex = -1;
  final List<String> buttonTexts = ["Create Account", "Login", "Guest"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Imageconstants.background),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Image.asset(Imageconstants.logo, height: 40.h, width: 40.w),
                SizedBox(height: 0.8.h),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: buttonTexts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                          index == 0
                              ? Get.offNamed(AppRoutes.createAccount)
                              : index == 1
                              ? Get.offNamed(AppRoutes.login)
                             : index == 2
                            ? Get.offNamed(AppRoutes.bottomNavigation)
                              : Container();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 40,
                          ),
                          decoration: BoxDecoration(
                            color:
                                selectedIndex == index
                                    ? Color(0XFF0548A0)
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color:
                                  selectedIndex == index
                                      ? Color(0XFF1DAEFF)
                                      : Colors.black,
                              width: 2,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            buttonTexts[index],
                            style: GoogleFonts.instrumentSans(
                              color:
                                  selectedIndex == index
                                      ? Colors.white
                                      : Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
