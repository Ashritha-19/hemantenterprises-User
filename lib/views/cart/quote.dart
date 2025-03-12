// ignore_for_file: deprecated_member_use, avoid_unnecessary_containers, avoid_single_cascade_in_expression_statements

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemantenterprises/constants/colorconstants.dart';
import 'package:hemantenterprises/constants/imageconstants.dart';
import 'package:hemantenterprises/constants/searchfield.dart';
import 'package:hemantenterprises/models/elevatedbuttonmodel.dart';
import 'package:hemantenterprises/routes/app_routes.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _landmark = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _pincode = TextEditingController();

  final List<Map<String, dynamic>> products = [
    {
      "name": "Product Name here",
      "brand": "Hindware",
      "category": "Water Closets",
      "price": 10500,
      "image": Imageconstants.waterClosets
    },
    {
      "name": "Product Name here",
      "brand": "Hindware",
      "category": "Water Closets",
      "price": 9500,
      "image": Imageconstants.image3
    },
    {
      "name": "Product Name here",
      "brand": "Hindware",
      "category": "Water Closets",
      "price": 12500,
      "image": Imageconstants.image1
    },
  ];

  int getTotalPrice() {
    return products.fold(0, (sum, item) => sum + item["price"] as int);
  }

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
                  opacity: 0.2, // 20% opacity for the entire background
                ),
              ),
            ),
          ),
          Column(
            children: [
              CustomAppBar(
                hintText: "Search",
                onSearchTap: () {
                  // Handle search bar tap
                },
              ),
              SizedBox(height: 1.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Quote",
                          style: GoogleFonts.instrumentSans(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 1.h),
                        Divider(
                          thickness: 1,
                          height: 1,
                          color: Colorconstants.brandLogoCircle,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          elevation: 5,
                          child: Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  final product = products[index];
                                  return Container(
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 5,
                                          spreadRadius: 2,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          child: Image.asset(
                                            product["image"],
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                product["name"],
                                                style:
                                                    GoogleFonts.instrumentSans(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 12,
                                                  color:
                                                      Colorconstants.darkBlack,
                                                ),
                                              ),
                                              SizedBox(height: 3),
                                              Text(
                                                "Brand: ${product["brand"]}",
                                                style:
                                                    GoogleFonts.instrumentSans(
                                                  color: Colorconstants
                                                      .brandLogoCircle,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                "Category: ${product["category"]}",
                                                style:
                                                    GoogleFonts.instrumentSans(
                                                  color: Colorconstants
                                                      .brandLogoCircle,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "₹ ${product["price"]}",
                                              style: GoogleFonts.instrumentSans(
                                                fontWeight: FontWeight.w500,
                                                color: Colorconstants.darkBlack,
                                                fontSize: 12,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  products.removeAt(index);
                                                });
                                              },
                                              icon: Icon(Icons.delete,
                                                  color:
                                                      Colorconstants.darkBlack),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 2.h),
                              DottedLine(
                                dashColor: Colorconstants.brandLogoCircle,
                                lineThickness: 1,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Sub Total",
                                      style: GoogleFonts.instrumentSans(
                                          fontWeight: FontWeight.w800,
                                          color: Colorconstants.darkBlack,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      "₹ ${getTotalPrice()}",
                                      style: GoogleFonts.instrumentSans(
                                          fontWeight: FontWeight.w500,
                                          color: Colorconstants.darkBlack,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    child: Text(
                                      "Promo Code",
                                      style: GoogleFonts.instrumentSans(
                                          fontWeight: FontWeight.w800,
                                          color: Colorconstants.darkBlack,
                                          fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Colorconstants.brandLogoCircle),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: "Enter promo code here",
                                              hintStyle:
                                                  GoogleFonts.instrumentSans(
                                                color: Colorconstants
                                                    .brandLogoCircle,
                                                fontSize:
                                                    12, // Slightly reduced font size
                                              ),
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.symmetric(
                                                  vertical: 8,
                                                  horizontal:
                                                      8), // Reduced padding inside TextField
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType
                                                  .success, // Animated success icon
                                              animType: AnimType
                                                  .scale, // Pop-up animation effect
                                              title: "🎉 Woohoo!",
                                              titleTextStyle:
                                                  GoogleFonts.instrumentSans(
                                                      color: Colors.green,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                              desc:
                                                  "Enjoy the discount! 🥳",
                                              descTextStyle:
                                                  GoogleFonts.instrumentSans(
                                                      color: Colorconstants
                                                          .darkBlack,
                                                      fontSize: 14),
                                              btnOkText: "OK",
                                              btnOkColor:
                                                  Colorconstants.primaryColor,
                                              btnOkOnPress:
                                                  () {}, // Closes the dialog automatically
                                            )..show();
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "Apply",
                                              style: GoogleFonts.instrumentSans(
                                                color:
                                                    Colorconstants.primaryColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.h),
                              DottedLine(
                                dashColor: Colorconstants.brandLogoCircle,
                                lineThickness: 1,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total",
                                      style: GoogleFonts.instrumentSans(
                                          fontWeight: FontWeight.w800,
                                          color: Colorconstants.darkBlack,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      "₹ ${getTotalPrice()}",
                                      style: GoogleFonts.instrumentSans(
                                          fontWeight: FontWeight.w500,
                                          color: Colorconstants.darkBlack,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h),
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
                                    'Customer Details',
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
                                    controller: _address,
                                    decoration: InputDecoration(
                                      hintText: "Address line 1",
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
                                        return "Please enter your address";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 1.h),

                                  TextFormField(
                                    controller: _landmark,
                                    decoration: InputDecoration(
                                      hintText: "Landmark(if any)",
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
                                        return "Please enter a landmark (if any)";
                                      }
                                      return null;
                                    },
                                  ),

                                  SizedBox(height: 1.h),

                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: DropdownButtonFormField<String>(
                                          value: _state.text.isNotEmpty
                                              ? _state.text
                                              : null,
                                          hint: Text(
                                            "State",
                                            style: GoogleFonts.instrumentSans(
                                              color: Colorconstants
                                                  .brandLogoCircle,
                                              fontSize: 12,
                                            ),
                                          ),
                                          decoration: InputDecoration(
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
                                              vertical: 5.0,
                                              horizontal: 15.0,
                                            ),
                                          ),
                                          items: [
                                            'Andhra Pradesh',
                                            'Arunachal Pradesh',
                                            'Assam',
                                            'Bihar',
                                            'Chhattisgarh',
                                            'Goa',
                                            'Gujarat',
                                            'Haryana',
                                            'Himachal Pradesh',
                                            'Jharkhand',
                                            'Karnataka',
                                            'Kerala',
                                            'Madhya Pradesh',
                                            'Maharashtra',
                                            'Manipur',
                                            'Meghalaya',
                                            'Mizoram',
                                            'Nagaland',
                                            'Odisha',
                                            'Punjab',
                                            'Rajasthan',
                                            'Sikkim',
                                            'Tamil Nadu',
                                            'Telangana',
                                            'Tripura',
                                            'Uttar Pradesh',
                                            'Uttarakhand',
                                            'West Bengal'
                                          ].map((String state) {
                                            return DropdownMenuItem<String>(
                                              value: state,
                                              child: Text(state,
                                                  style: GoogleFonts
                                                      .instrumentSans(
                                                          fontSize: 12)),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            if (newValue != null) {
                                              _state.text = newValue;
                                            }
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please select a state";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: TextFormField(
                                          controller: _city,
                                          decoration: InputDecoration(
                                            hintText: "City",
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
                                              return "Please enter your city";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: TextFormField(
                                          keyboardType: TextInputType.phone,
                                          controller: _pincode,
                                          decoration: InputDecoration(
                                            hintText: "Pincode",
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
                                              return "Please enter your pincode";
                                            } else if (value.length != 6) {
                                              return "Pincode must be exactly 6 digits";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 2.h),

                                  // Custom Elevated Button
                                  CustomElevatedButton(
                                    text: "Submit",
                                    textStyle: GoogleFonts.instrumentSans(
                                      color: Colorconstants.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 30),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        Get.offNamed(AppRoutes.thankyou);
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
                        SizedBox(height: 20),
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
