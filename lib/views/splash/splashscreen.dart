import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hemantenterprises/constants/imageconstants.dart';
import 'package:hemantenterprises/routes/app_routes.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 
 @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Get.offNamed(AppRoutes.next);
    });
  }
 

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                Imageconstants.background, 
                fit: BoxFit.cover,
              ),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
             Center(child: Image.asset(Imageconstants.logo,height: 200,))
                ],
              ),
            ),
          ],
        );
  }
}