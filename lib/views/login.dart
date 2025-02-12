// ignore_for_file: library_private_types_in_public_api

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
    // Defines an async function _handleTap.
    if (!_isLoading) {
      // Checks if _isLoading is false, meaning the process is not already running.
      setState(() {
        // Updates the UI to show a loading indicator.
        _isLoading = true; // Sets _isLoading to true.
      });

      if (_formKey.currentState!.validate()) {
        // Validates the form using _formKey. Ensures all form inputs are correct.
        // Trigger Firebase phone authentication
        try {
          // Begins a try block to catch any errors during phone verification.
          await FirebaseAuth.instance.verifyPhoneNumber(
            // Calls Firebase's phone authentication method.
            phoneNumber:
                '+91 ${_phoneController.text.trim()}', // Formats and passes the phone number.
            verificationCompleted: (PhoneAuthCredential credential) {
              // Callback for automatic verification.
              FirebaseAuth.instance
                  .signInWithCredential(credential)
                  .then((value) {
                // Signs in the user automatically with the provided credential.
                Fluttertoast.showToast(
                  // Displays a success message.
                  msg:
                      "Phone number verified and user signed in!", // Message shown in the toast.
                  backgroundColor: Colors.green, // Toast background color.
                );
                Get.toNamed(AppRoutes
                    .verificationCode); // Navigates to the OTP screen using GetX routes.
              });
            },
            verificationFailed: (FirebaseAuthException e) {
              // Callback for failed verification.
              Fluttertoast.showToast(
                // Displays a failure message.
                msg:
                    "Verification failed: ${e.message}", // Shows the specific error message.
                backgroundColor: Colors.red, // Toast background color.
              );

              print("${e.message}hello");
            },
            codeSent: (String verificationId, int? resendToken) {
              // Callback for when the OTP code is sent.
              _verificationId = verificationId; // Stores the verification ID.
              Fluttertoast.showToast(
                // Displays a success message.
                msg: "Verification code sent!", // Message indicating code sent.
                backgroundColor: Colors.blue, // Toast background color.
              );

              // Navigate to the OTP screen
              Get.toNamed(AppRoutes.verificationCode, arguments: {
                // Navigates to the OTP screen and passes arguments.
                "verificationId":
                    _verificationId, // Passes the verification ID to the next screen.
              });
            },
            codeAutoRetrievalTimeout: (String verificationId) {
              // Callback for timeout when auto-retrieval fails.
              _verificationId =
                  verificationId; // Stores the verification ID even after timeout.
            },
          );
        } catch (e) {
          // Catch block to handle any errors during the phone verification process.
          Fluttertoast.showToast(
            // Displays an error message.
            msg: "An error occurred: $e", // Shows the specific error.
            backgroundColor: Colors.red, // Toast background color.
          );
        }
      } else {
        // Runs if form validation fails.
        Fluttertoast.showToast(
          // Displays an error message.
          msg: "Please fill all details", // Error message for incomplete form.
          backgroundColor: Colors.black, // Toast background color.
          textColor: Colors.white, // Toast text color.
        );
      }

      // Simulate loading delay
      Future.delayed(Duration(seconds: 2), () {
        // Delays for 2 seconds to simulate loading time.
        setState(() {
          // Updates the UI.
          _isLoading =
              false; // Sets _isLoading back to false, stopping the loading indicator.
        });
      });
    }
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
