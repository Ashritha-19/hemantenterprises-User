import 'package:flutter/material.dart';
import 'package:hemantenterprises/constants/colorconstants.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double elevation;
  final EdgeInsetsGeometry contentPadding;
  final TextStyle? textStyle;

  const CustomElevatedButton({super.key, 
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colorconstants.primaryColor, // Default background color
    this.textColor = Colorconstants.white, // Default text color
    this.borderRadius = 30.0, // Default border radius
    this.elevation = 10.0, // Default elevation
    this.contentPadding = const EdgeInsets.all(8.0), this.textStyle, // Default padding
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor, backgroundColor: backgroundColor,
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: contentPadding,
      ),
      onPressed: onPressed,
      child: Text(text, style: TextStyle(fontSize: 16)),
    );
  }
}
