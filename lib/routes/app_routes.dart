import 'package:get/get.dart';
import 'package:hemantenterprises/bottomnavigation/bottomnavigation.dart';
import 'package:hemantenterprises/views/aboutUs.dart';
import 'package:hemantenterprises/views/brandDetails.dart';
import 'package:hemantenterprises/views/category.dart';
import 'package:hemantenterprises/views/createaccount.dart';
import 'package:hemantenterprises/views/home.dart';
import 'package:hemantenterprises/views/listingpage.dart';
import 'package:hemantenterprises/views/login.dart';
import 'package:hemantenterprises/views/otp.dart';
import 'package:hemantenterprises/views/profile.dart';
import 'package:hemantenterprises/views/quote.dart';
import 'package:hemantenterprises/views/searchresult.dart';
import 'package:hemantenterprises/views/splashcontext.dart';
import 'package:hemantenterprises/views/splashscreen.dart';
import 'package:hemantenterprises/views/subcategory.dart';
import 'package:hemantenterprises/views/thankyou.dart';



class AppRoutes {
  static const splash = '/splash';
  static const next = '/next';
  static const createAccount = '/createAccount';
  static const login = '/login';
  static const verificationCode = '/verificationCode';
  static const home = '/home';
  static const brandDetails = '/brandDetails';
  static const category = '/category';
  static const subCategory = '/subCategory';
  static const listingPage = '/listingPage';
  static const bottomNavigation= '/bottomNavigation';
  static const quote = '/quote';
  static const aboutUs = '/aboutUs';
  static const profile = '/profile';
  static const search = '/search';
  static const thankyou = '/thankyou';


  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: next,
      page: () => SplashContext(),
    ),
    GetPage(
     name: createAccount,
     page: () => CreateAccountScreen(),
    ),
    GetPage(
      name: login, 
      page: () => LoginScreen(),
    ),
    GetPage(
      name: verificationCode, 
      page: () => VerificationCodeScreen()
      ),
    GetPage(
      name: home, 
      page: () => HomeScreen()
      ),
    GetPage(
      name: brandDetails, 
      page: () => BrandDetailsScreen()
      ),   
    GetPage(
      name: category, 
      page: () => CategoryScreen()
      ),   
    GetPage(
      name: subCategory, 
      page: () => SubCategoryScreen()
      ),
    GetPage(
      name: listingPage, 
      page: () => ListingPageScreen()
      ),  
    GetPage(
      name: bottomNavigation, 
      page: () => BottomNavigation()
      ), 
    GetPage(
      name: quote, 
      page: () => QuoteScreen()
      ), 
    GetPage(
      name: aboutUs, 
      page: () => AboutUsScreen()
      ), 
    GetPage(
      name: search, 
      page: () => SearchResultScreen()
      ),
    GetPage(
      name: profile, 
      page: () => ProfileScreen()
      ),
    GetPage(
      name: thankyou, 
      page: () => ThankYouScreen()
      ),
 

  ];
}
