// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, avoid_print, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hemantenterprises/constants/colorconstants.dart';
import 'package:hemantenterprises/constants/imageconstants.dart';
import 'package:hemantenterprises/models/createaccountmodel.dart';
import 'package:hemantenterprises/models/elevatedbuttonmodel.dart';
import 'package:hemantenterprises/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _privacyChecked = false;
  String? _verificationId;
  bool _isLoading = false;

  void _handleTap() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      showLoadingDialog(context);

      if (_formKey.currentState!.validate()) {
        print('name:${_nameController.text}');
        print('email:${_emailController.text}');

        // Check if values are not empty
        if (_nameController.text.trim().isEmpty ||
            _emailController.text.trim().isEmpty ||
            _phoneController.text.trim().isEmpty) {
          Fluttertoast.showToast(
            msg: "Please fill all details",
            backgroundColor: Colors.red,
          );

          setState(() {
            _isLoading = false;
          });

          return; // Stop further execution
        }

        if (!_privacyChecked) {
          Fluttertoast.showToast(
            msg: "Please agree to the Privacy Policy",
            backgroundColor: Colors.red,
          );
          setState(() {
            _isLoading = false;
          });
          return;
        }

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', '${_nameController.text.toString()}');
        await prefs.setString('useremail', '${_emailController.text.toString()}');
            

        try {
          await FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: '+91 ${_phoneController.text.trim()}',
            verificationCompleted: (PhoneAuthCredential credential) async {
              await FirebaseAuth.instance.signInWithCredential(credential);
              Fluttertoast.showToast(
                msg: "Phone number verified and user signed in!",
                backgroundColor: Colors.green,
              );

              Get.toNamed(AppRoutes.registerUserVerification, arguments: {
                "verificationId": _verificationId,
                "fullName": _nameController.text.trim(),
                "email": _emailController.text.trim(),
              });
            },
            verificationFailed: (FirebaseAuthException e) {
              Fluttertoast.showToast(
                msg: "Verification failed: ${e.message}",
                backgroundColor: Colors.red,
              );
            },
            codeSent: (String verificationId, int? resendToken) {
              _verificationId = verificationId;
              Fluttertoast.showToast(
                msg: "Verification code sent!",
                backgroundColor: Colors.blue,
              );
              Get.toNamed(AppRoutes.registerUserVerification, arguments: {
                "verificationId": _verificationId,
              });
            },
            codeAutoRetrievalTimeout: (String verificationId) {
              _verificationId = verificationId;
            },
          );
        } catch (e) {
          Fluttertoast.showToast(
            msg: "An error occurred: $e",
            backgroundColor: Colors.red,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Please fill all details",
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      }

      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/icons/logo.png', // Your loading image (Add it to assets folder)
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 10),
              const CircularProgressIndicator(),
              const SizedBox(height: 10),
              const Text(
                "Please wait...",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Imageconstants.background),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Create an Account',
                          style: GoogleFonts.instrumentSans(
                            fontSize:
                                20.sp, // Use 20.sp for responsive font size
                            fontWeight: FontWeight.bold,
                            color: Colorconstants.white,
                          ),
                        ),
                        SizedBox(
                            height:
                                7.h), // Use 7.h for responsive vertical spacing
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Full Name',
                            style: GoogleFonts.instrumentSans(
                              fontSize:
                                  14.sp, // Use 14.sp for responsive font size
                              color: Colorconstants.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h), // Use 1.h for responsive spacing
                        CustomTextFormField(
                          hintText: 'Enter your name',
                          hintStyle: GoogleFonts.instrumentSans(
                            fontSize:
                                14.sp, // Use 14.sp for responsive font size
                            color: Colorconstants.textField,
                          ),
                          controller: _nameController,
                          prefixIcon: Icon(Icons.person),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 2.h), // Use 2.h for responsive spacing
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Phone Number',
                            style: GoogleFonts.instrumentSans(
                              fontSize:
                                  14.sp, // Use 14.sp for responsive font size
                              color: Colorconstants.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h), // Use 1.h for responsive spacing
                        CustomTextFormField(
                          hintText: 'Enter your number',
                          hintStyle: GoogleFonts.instrumentSans(
                            fontSize:
                                14.sp, // Use 14.sp for responsive font size
                            color: Colorconstants.textField,
                          ),
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          prefixIcon: Icon(Icons.phone),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            if (value.length < 10) {
                              return 'Phone number must be at least 10 digits';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 2.h), // Use 2.h for responsive spacing
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Email ID',
                            style: GoogleFonts.instrumentSans(
                              fontSize:
                                  14.sp, // Use 14.sp for responsive font size
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h), // Use 1.h for responsive spacing
                        CustomTextFormField(
                          hintText: 'Enter your email id',
                          hintStyle: GoogleFonts.instrumentSans(
                            fontSize:
                                14.sp, // Use 14.sp for responsive font size
                            color: Colorconstants.textField,
                          ),
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: Icon(Icons.mail),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email ID';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: _privacyChecked,
                              onChanged: (value) {
                                setState(() {
                                  _privacyChecked = value!;
                                });
                              },
                              checkColor: Colors.blue,
                              activeColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3
                                    .sp), // Use 3.sp for responsive border radius
                              ),
                              side: BorderSide(
                                color: _privacyChecked
                                    ? Colors.blue
                                    : Colors.black,
                                width: 2.sp, // Use 2.sp for responsive width
                              ),
                            ),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  text:
                                      'We value your privacy. The details you provide during sign-up are used solely to create your account and enhance your experience. We do not share your information with any third parties. By signing up, you agree to our ',
                                  style: GoogleFonts.instrumentSans(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colorconstants.white,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Terms of Service',
                                      style: GoogleFonts.instrumentSans(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colorconstants
                                            .secondaryColor, // Gold color
                                        decoration: TextDecoration
                                            .underline, // To make it look like a link
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // Navigate to Terms of Service page
                                        },
                                    ),
                                    TextSpan(
                                      text: ' and ',
                                      style: GoogleFonts.instrumentSans(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Privacy Policy',
                                      style: GoogleFonts.instrumentSans(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colorconstants
                                            .secondaryColor, // Gold color
                                        decoration: TextDecoration
                                            .underline, // To make it look like a link
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // Navigate to Privacy Policy page
                                        },
                                    ),
                                    TextSpan(
                                      text: '.',
                                      style: GoogleFonts.instrumentSans(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height:
                                5.h), // Use 1.h for responsive vertical spacing
                        SizedBox(
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  color: Colorconstants.primaryColor,
                                ) // Show loading when processing
                              : CustomElevatedButton(
                                  text: 'Send Verification Code',
                                  textStyle: GoogleFonts.sen(
                                    fontSize: 30.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                    color: Colorconstants.white,
                                  ),
                                  onPressed: _handleTap,
                                  backgroundColor: Colorconstants.primaryColor,
                                  textColor: Colorconstants.white,
                                  borderRadius: 30.sp,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 2.h, horizontal: 18.w),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
