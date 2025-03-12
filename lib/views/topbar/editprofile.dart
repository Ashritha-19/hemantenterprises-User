import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemantenterprises/constants/colorconstants.dart';
import 'package:hemantenterprises/constants/imageconstants.dart';
import 'package:hemantenterprises/constants/searchfield.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _landmark = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _pincode = TextEditingController();

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
    return Scaffold(
      body: Stack(
        children: [
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
                  // Define action when search bar is tapped
                },
              ),
              SizedBox(
                height: 2.h,
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Edit Profile',
                        style: GoogleFonts.instrumentSans(
                            color: Colorconstants.darkBlack,
                            fontSize: 14,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(height: 2.h),
                      Divider(
                        thickness: 1,
                        height: 1,
                        color: Colorconstants.brandLogoCircle,
                      ),
                      Padding(
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
                                  fillColor: Colorconstants.white,
                                  
                                  hintStyle: GoogleFonts.instrumentSans(
                                    color: Colorconstants.brandLogoCircle,
                                    fontSize: 12,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(
                                      color: Colorconstants.brandLogoCircle,
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(
                                      color: Colorconstants.brandLogoCircle,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(
                                      color: Colorconstants.brandLogoCircle,
                                      width: 1,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
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
                                        hintStyle: GoogleFonts.instrumentSans(
                                          color: Colorconstants.brandLogoCircle,
                                          fontSize: 12,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                            color:
                                                Colorconstants.brandLogoCircle,
                                            width: 1,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                            color:
                                                Colorconstants.brandLogoCircle,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                            color:
                                                Colorconstants.brandLogoCircle,
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
                                        hintStyle: GoogleFonts.instrumentSans(
                                          color: Colorconstants.brandLogoCircle,
                                          fontSize: 12,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                            color:
                                                Colorconstants.brandLogoCircle,
                                            width: 1,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                            color:
                                                Colorconstants.brandLogoCircle,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                            color:
                                                Colorconstants.brandLogoCircle,
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
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(
                                      color: Colorconstants.brandLogoCircle,
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(
                                      color: Colorconstants.brandLogoCircle,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(
                                      color: Colorconstants.brandLogoCircle,
                                      width: 1,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
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
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(
                                      color: Colorconstants.brandLogoCircle,
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(
                                      color: Colorconstants.brandLogoCircle,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(
                                      color: Colorconstants.brandLogoCircle,
                                      width: 1,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
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
                                          color: Colorconstants.brandLogoCircle,
                                          fontSize: 12,
                                        ),
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                            color:
                                                Colorconstants.brandLogoCircle,
                                            width: 1,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                            color:
                                                Colorconstants.brandLogoCircle,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                            color:
                                                Colorconstants.brandLogoCircle,
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
                                              style: GoogleFonts.instrumentSans(
                                                  fontSize: 12)),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        if (newValue != null) {
                                          _state.text = newValue;
                                        }
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
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
                                        hintStyle: GoogleFonts.instrumentSans(
                                          color: Colorconstants.brandLogoCircle,
                                          fontSize: 12,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                            color:
                                                Colorconstants.brandLogoCircle,
                                            width: 1,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                            color:
                                                Colorconstants.brandLogoCircle,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                            color:
                                                Colorconstants.brandLogoCircle,
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
                                        hintStyle: GoogleFonts.instrumentSans(
                                          color: Colorconstants.brandLogoCircle,
                                          fontSize: 12,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                            color:
                                                Colorconstants.brandLogoCircle,
                                            width: 1,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                            color:
                                                Colorconstants.brandLogoCircle,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                            color:
                                                Colorconstants.brandLogoCircle,
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
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _showToast("Details saved Successfully");
                                  } else {
                                    _showToast("Please enter valid details");
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colorconstants.primaryColor,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 24),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  'Save',
                                  style: GoogleFonts.instrumentSans(
                                    color: Colorconstants.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
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
