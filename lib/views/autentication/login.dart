// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  String? _verificationId;
  bool _isLoading = false;

  void _handleTap() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      if (_formKey.currentState!.validate()) {
        print(
            "Form validation successful. Proceeding with phone number verification...");

        try {
          await FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: '+91 ${_phoneController.text.trim()}',
            verificationCompleted: (PhoneAuthCredential credential) async {
              print("Auto verification completed. Signing in...");

              // Auto sign-in with Firebase
              await FirebaseAuth.instance.signInWithCredential(credential);
              print("Firebase sign-in successful!");

              // Call API after Firebase verification
              print("Calling API to log in after verification...");
              //  await _sendLoginRequest();

              Fluttertoast.showToast(
                msg: "Phone verified successfully!",
                backgroundColor: Colors.green,
              );

              print("Navigating to verification screen...");
              Get.toNamed(AppRoutes.loginVerification);
            },
            verificationFailed: (FirebaseAuthException e) {
              print("Verification failed: ${e.message}");
              Fluttertoast.showToast(
                msg: "Verification failed: ${e.message}",
                backgroundColor: Colors.red,
              );
            },
            codeSent: (String verificationId, int? resendToken) {
              _verificationId = verificationId;
              print("OTP code sent! Verification ID: $_verificationId");

              Fluttertoast.showToast(
                msg: "Verification code sent!",
                backgroundColor: Colors.blue,
              );

              print("Navigating to verification code screen...");
              Get.toNamed(AppRoutes.loginVerification, arguments: {
                "verificationId": _verificationId,
              });
            },
            codeAutoRetrievalTimeout: (String verificationId) {
              _verificationId = verificationId;
              print(
                  "Code auto-retrieval timeout. Verification ID: $_verificationId");
            },
          );
        } catch (e) {
          print("Error during phone authentication: $e");
          Fluttertoast.showToast(
            msg: "An error occurred: $e",
            backgroundColor: Colors.red,
          );
        }
      } else {
        print("Form validation failed. Please fill all details.");
        Fluttertoast.showToast(
          msg: "Please fill all details",
          backgroundColor: Colors.black,
        );
      }

      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          _isLoading = false;
        });
        print("Loading state reset.");
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
                'assets/icons/logo.png', 
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
      body: Stack(
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
          SizedBox(height: 10.h),
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
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: SizedBox(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 15.h),
                                Text(
                                  'Login',
                                  style: GoogleFonts.instrumentSans(
                                    fontSize: 20.sp, // Responsive font size
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 7.h), // Responsive height

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Phone Number',
                                    style: GoogleFonts.instrumentSans(
                                      fontSize: 14.sp, // Responsive font size
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 1.h), // Responsive height
                                CustomTextFormField(
                                  hintText: 'Enter your number',
                                  hintStyle: GoogleFonts.instrumentSans(
                                    fontSize: 14.sp, // Responsive font size
                                    color: Color(0XFFA7A9B7),
                                  ),
                                  controller: _phoneController,
                                  keyboardType: TextInputType.number,
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
                                SizedBox(height: 10.h), // Responsive height
                              ],
                            ),
                          ),
                        ),
                      ),
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
                                  color: const Color(0XFFFFFFFF),
                                ),
                                onPressed: _handleTap,
                                backgroundColor: const Color(0xFF0548A0),
                                textColor: Colors.white,
                                borderRadius:
                                    30.0, // Match the original border radius
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 2.h,
                                    horizontal:
                                        18.w), // Match the original padding
                              ),
                      ),
                      SizedBox(height: 10.h)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
