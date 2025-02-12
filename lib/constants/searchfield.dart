// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemantenterprises/constants/colorconstants.dart';
import 'package:hemantenterprises/constants/imageconstants.dart';
import 'package:hemantenterprises/routes/app_routes.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String hintText;
  final VoidCallback? onSearchTap;

  const CustomAppBar({
    Key? key,
    this.hintText = "Search",
    this.onSearchTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 80,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Image.asset(
          Imageconstants.logo,
          height: 100,
          width: 100,
        ),
      ),
      title: TextField(
        onTap: () {
          Get.offNamed(AppRoutes.search);
        },
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(2),
          hintStyle: GoogleFonts.instrumentSans(
            fontSize: 12,
            color: const Color(0XFF010101),
          ),
          prefixIcon: Image.asset(Imageconstants.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      actions: [
        PopupMenuButton<int>(
          icon: Image.asset(
            Imageconstants.menu,
            width: 50,
            height: 50,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          offset: Offset(0, 50), // Adjust position of popup
          onSelected: (value) {
            if (value == 1) {
              Get.toNamed(AppRoutes.profile);
            } else if (value == 2) {
              _showLogoutDialog(context);
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Color(0xFFD3E6FF),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    "Profile",
                    style: GoogleFonts.instrumentSans(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            PopupMenuItem(
              value: 2,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Color(0xFFD3E6FF),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    "Logout",
                    style: GoogleFonts.instrumentSans(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Logout",
          style: GoogleFonts.instrumentSans(
              color: Colorconstants.darkBlack, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        content: Text(
          "Are you sure you want to logout?",
          style: GoogleFonts.instrumentSans(
              color: Colorconstants.darkBlack, fontWeight: FontWeight.w500, fontSize: 12),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.offAllNamed(AppRoutes.login);
            },
            child: Text(
              "Logout",
              style: GoogleFonts.instrumentSans(
                  color: Colorconstants.primaryColor, fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Cancel",
              style: GoogleFonts.instrumentSans(
                  color: Colorconstants.darkBlack, fontWeight: FontWeight.w500, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
