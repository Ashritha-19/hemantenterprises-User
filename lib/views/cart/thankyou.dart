import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemantenterprises/constants/colorconstants.dart';
import 'package:hemantenterprises/constants/imageconstants.dart';
import 'package:hemantenterprises/constants/searchfield.dart';
import 'package:hemantenterprises/routes/app_routes.dart';

class ThankYouScreen extends StatefulWidget {
  const ThankYouScreen({super.key});

  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {

 @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Get.offNamed(AppRoutes.bottomNavigation);
    });
  }

  @override
  Widget build(BuildContext context) {
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

          Column(
            children: [
              CustomAppBar(
                hintText: "Search",
                onSearchTap: () {
                 
                },
              ),

          
              SizedBox(height: 25.h,),
           
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Imageconstants.thankyou),
                    SizedBox(height: 1.h),
                    Text(
                      'Thank You',
                      style: GoogleFonts.instrumentSans(
                        color: Colorconstants.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'You will receive a mail with Quote.',
                      style: GoogleFonts.instrumentSans(
                        color: Colorconstants.darkBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),           
             Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
