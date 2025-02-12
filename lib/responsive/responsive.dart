import 'package:flutter/material.dart';

class Responsive {
  // Breakpoints
  static const double compactMobileMaxWidth = 360;
  static const double mobileMaxWidth = 600;
  static const double tabletMaxWidth = 1024;

  // Check if the device is compact mobile
  static bool isCompactMobile(BuildContext context) {
    return MediaQuery.of(context).size.width <= compactMobileMaxWidth;
  }

  // Check if the device is mobile
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width > compactMobileMaxWidth &&
        MediaQuery.of(context).size.width <= mobileMaxWidth;
  }

  // Check if the device is tablet
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width > mobileMaxWidth && width <= tabletMaxWidth;
  }

  // Check if the device is desktop
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width > tabletMaxWidth;
  }

  // Get dynamic height based on screen size
  static double dynamicHeight(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * percentage;
  }

  // Get dynamic width based on screen size
  static double dynamicWidth(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * percentage;
  }

  // Get responsive font size
  static double dynamicFontSize(BuildContext context, double baseSize) {
    if (isCompactMobile(context)) return baseSize * 0.8; // Smaller fonts for compact screens
    if (isMobile(context)) return baseSize; // Base size for regular mobile screens
    if (isTablet(context)) return baseSize * 1.2; // Slightly larger for tablets
    if (isDesktop(context)) return baseSize * 1.5; // Larger for desktops
    return baseSize; // Default
  }
}