// ignore_for_file: deprecated_member_use, avoid_print, use_build_context_synchronously, unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemantenterprises/constants/apiservices.dart';
import 'package:hemantenterprises/constants/colorconstants.dart';
import 'package:hemantenterprises/constants/imageconstants.dart';
import 'package:hemantenterprises/models/elevatedbuttonmodel.dart';
import 'package:hemantenterprises/routes/app_routes.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginVerification extends StatefulWidget {
  const LoginVerification({super.key});

  @override
  State<LoginVerification> createState() => _LoginVerificationState();
}

class _LoginVerificationState extends State<LoginVerification> {
  // Controllers for OTP TextFields

  late Timer _timer;
  int _start = 30; // Timer starts at 30 seconds
  String _otpCode = "";
  bool _isResendEnabled = false;
  late String _verificationId;

  String? userUid;
  String? userIdentifier;

  @override
  void initState() {
    super.initState();
    _verificationId = Get.arguments["verificationId"];
    startTimer();
  }

  // @override
  // void initState() {
  //   super.initState();

  //   // Check if Get.arguments is null or contains the required key
  //   if (Get.arguments != null && Get.arguments.containsKey("verificationId")) {
  //     _verificationId = Get.arguments["verificationId"];
  //   } else {
  //     // Handle the error or fallback case if arguments are missing
  //     Fluttertoast.showToast(
  //       msg: "Verification ID not found!",
  //       backgroundColor: Colors.red,
  //     );
  //     // Optionally, navigate to another screen or show an error message
  //     // Get.offAllNamed(AppRoutes.errorPage); // Example navigation
  //   }

  //   startTimer();
  // }

  void startTimer() {
    _isResendEnabled = false;
    _start = 30;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _isResendEnabled = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void validateOtp() async {
    if (_otpCode.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid 6-digit OTP')),
      );
    } else {
      try {
        // Create a PhoneAuthCredential using the verificationId and OTP entered by the user
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId,
          smsCode: _otpCode,
        );

        // Sign in with the credential
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) async {
          Fluttertoast.showToast(
            msg: "OTP Verified Successfully!",
            backgroundColor: Colors.green,
          );

          // Get the user UID and Identifier
          userUid = value.user?.uid ?? '';
          userIdentifier = value.user?.phoneNumber ?? '';

          // Store the UID and Identifier in the provider
          // Provider.of<UserProvider>(context, listen: false)
          //     .setUserDetails(userUid!, userIdentifier!);

          // Print the UID and Identifier
          print('User UID: $userUid');
          print('User Identifier: $userIdentifier');

          // Navigate to the next screen after successful verification
          _saveLoginData(context);
        });
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Invalid OTP or verification failed!",
          backgroundColor: Colors.red,
        );
      }
    }
  }

  Future<void> _saveLoginData(BuildContext context) async {
    const String apiUrl = '${ApiConstants.baseUrl}${ApiConstants.login}';

    print(userUid);
    print(userIdentifier);

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    Map<String, dynamic> requestBody = {
      "userPhoneNumner": userIdentifier,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      print("Response Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        print('$responseData >>>>>>>>>>>>>>');
        print('${responseData['error']}>>>>>>>>>>>>>>>>>>error');
        print('${responseData['message']}>>>>>>>>>>>>>>>>>>>message');
        if(responseData['message'] == "Login successful"){
         
          Fluttertoast.showToast(
            msg: responseData['message'].toString());
            Get.toNamed(AppRoutes.bottomNavigation);

           // Store the access token in SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString(
              'access_token', responseData['access_token'].toString());

        }else{
          Fluttertoast.showToast(
            msg: "Invalid phone number, please sign up");
           
        }      

        print("Success: ${response.body}");
      } else {
        Fluttertoast.showToast(
            msg: response.body.toString(),backgroundColor: Colors.red);
            Get.toNamed(AppRoutes.createAccount);
        print("Failed: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
    // try {
    //   // Log the API URL and headers before sending the request
    //   print("Sending POST request to: $apiUrl");
    //   print("Request Headers: ${{"Content-Type": "application/json"}}");
    //   print("Final Request JSON: ${json.encode(requestBody)}");

    //   final response = await http.post(
    //     Uri.parse(apiUrl),
    //     headers: {"Content-Type": "application/json"},
    //     body: json.encode(requestBody),
    //   );

    //   // Log the response status and body for debugging
    //   print("API Response Status Code: ${response.statusCode}");
    //   print("API Response Body: ${response.body}");

    //   if (response.statusCode == 200) {
    //     final Map<String, dynamic> responsedata = jsonDecode(response.body);

    //     print('${responsedata}........................');
    //     // Log success and navigate
    //     Fluttertoast.showToast(
    //         msg: "Login successful!", backgroundColor: Colors.green);
    //     print("Login successful. Navigating to bottom navigation screen...");
    //     Get.offAllNamed(AppRoutes
    //         .bottomNavigation); // Navigate to home screen after successful login
    //   } else {
    //     // Log failure
    //     Fluttertoast.showToast(
    //         msg: "Login failed. Try again.", backgroundColor: Colors.red);
    //     print("Login failed. Response: ${response.body}");
    //   }
    // } catch (e) {
    //   // Log the error if the request fails
    //   Fluttertoast.showToast(msg: "Error: $e", backgroundColor: Colors.red);
    //   print("Error occurred: $e");
    // }
  }

  @override
  Widget build(BuildContext context) {
    // Convert remaining time to minutes and seconds

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
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        'Verification Code',
                        style: GoogleFonts.instrumentSans(
                          fontSize: 20.sp,
                          color: Colorconstants.white,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'We have sent the code verification to your number\n+91 983845 XXXX',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.instrumentSans(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: Colorconstants.white,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      SizedBox(height: 20),
                      OtpTextField(
                        numberOfFields: 6,
                        showFieldAsBox: true,
                        borderRadius: BorderRadius.circular(10),
                        fillColor: Color(0xFFF8F9FB),
                        filled: true,
                        fieldWidth: 50.0,
                        onCodeChanged: (String code) {
                          // Update OTP code on change
                          _otpCode = code;
                        },
                        onSubmit: (String verificationCode) {
                          _otpCode = verificationCode;
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        _start > 0
                            ? "Resend Code in $_start seconds"
                            : "You can resend the code now",
                        style: GoogleFonts.instrumentSans(
                          fontSize: 16,
                          color: Color(0XFF1DAEFF),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: _isResendEnabled
                            ? () {
                                // Resend code logic
                                startTimer();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Code Resent')),
                                );
                              }
                            : null, // Disable button until timer completes
                        child: Text(
                          'Resend Code',
                          style: GoogleFonts.instrumentSans(
                            fontSize: 16.sp,
                            color: _isResendEnabled
                                ? Colorconstants.white
                                : Colorconstants.brandLogoCircle,
                            decoration: TextDecoration.underline,
                            decorationColor: Colorconstants.bottomNav,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomElevatedButton(
                        text: 'Login',
                        textStyle: GoogleFonts.sen(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w600,
                          color: Colorconstants.white,
                        ),
                        onPressed: () {
                          validateOtp(); // Call OTP submission function
                        },
                        backgroundColor: Colorconstants.primaryColor,
                        textColor: Colorconstants.white,
                        borderRadius: 30.sp,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 18.w),
                      ),
                    ],
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
