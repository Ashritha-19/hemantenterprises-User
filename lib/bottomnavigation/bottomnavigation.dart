// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemantenterprises/constants/colorconstants.dart';
import 'package:hemantenterprises/constants/imageconstants.dart';
import 'package:hemantenterprises/views/aboutUs.dart';
import 'package:hemantenterprises/views/brands/home.dart';
import 'package:hemantenterprises/views/cart/quote.dart';


class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() =>
      _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 1;  // Index for selected page

  // List of pages to show
  final List<Widget> _pages = [
    QuoteScreen(),
    HomeScreen(),
    AboutUsScreen(),
  ];

  // List of icon paths for selected and unselected states
  final List<BottomNavigationBarItem> _bottomNavItems = [

    BottomNavigationBarItem(
      icon: Image.asset(Imageconstants.quote, height: 50,width: 50),
      activeIcon: Image.asset(Imageconstants.selectedQuote, height: 50, width: 50),
      label: 'Quote', 
      
    ),
    BottomNavigationBarItem(
      icon: Image.asset(Imageconstants.home, height: 50,width: 50),
      activeIcon: Image.asset(Imageconstants.selectedHome, height: 50, width: 50),
      label: 'Home',    
    ),
    BottomNavigationBarItem(
      icon: Image.asset(Imageconstants.aboutUs, height: 50, width: 50),
      activeIcon: Image.asset(Imageconstants.selectedAboutUs, height: 50, width: 50),
      label: 'AboutUs',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected page
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],  // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,  // Keep track of the selected index
        onTap: _onItemTapped,  // Callback when an item is tapped
        items: _bottomNavItems,
        selectedLabelStyle: GoogleFonts.instrumentSans(
        fontSize: 10,
        color: Colorconstants.primaryColor        
        ),
        unselectedLabelStyle: GoogleFonts.instrumentSans(
        fontSize: 10,
        color: Colorconstants.darkBlack
          )  // Use the items list for icons
      ),
    );
  }
}