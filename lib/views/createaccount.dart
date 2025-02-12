// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Import fluttertoast package
import 'package:hemantenterprises/constants/colorconstants.dart';
import 'package:hemantenterprises/constants/imageconstants.dart';
import 'package:hemantenterprises/models/createaccountmodel.dart';
import 'package:hemantenterprises/models/elevatedbuttonmodel.dart';
import 'package:hemantenterprises/routes/app_routes.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _privacyChecked = false;
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
                backgroundColor:
                    Colorconstants.secondaryColor, // Toast background color.
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
          textColor: Colorconstants.white, // Toast text color.
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
  } // Ends the _handleTap function.

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
