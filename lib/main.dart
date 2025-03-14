import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:hemantenterprises/firebase_options.dart';
import 'package:hemantenterprises/providers/register.dart';
import 'package:hemantenterprises/providers/userprovider.dart';
import 'package:hemantenterprises/routes/app_routes.dart';
import 'package:hemantenterprises/views/splash/splashscreen.dart';
import 'package:provider/provider.dart';


void main() async{
 WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(  MultiProvider(
     // Provide UserProvider to the app
      providers: [ 
      ChangeNotifierProvider(create: (context) => CreateAccountProvider()),
      ChangeNotifierProvider(create: (context) => UserProvider()), ],
      child: const MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hemant Enterprises',
          home: SplashScreen(),
          getPages: AppRoutes.routes, 
        );
      },
    );
  }
}
