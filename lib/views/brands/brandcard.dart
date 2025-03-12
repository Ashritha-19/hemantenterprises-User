
import 'dart:convert';

import 'package:flutter/material.dart';

class BrandCard extends StatelessWidget {
  final Map<String, dynamic> jsonData;

  const BrandCard({Key? key, required this.jsonData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedJson = JsonEncoder.withIndent('  ').convert(jsonData); // Pretty Print JSON

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Text(
            formattedJson,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}