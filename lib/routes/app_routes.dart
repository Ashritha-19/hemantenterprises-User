import 'package:get/get.dart';
import 'package:hemantenterprises/bottomnavigation/bottomnavigation.dart';
import 'package:hemantenterprises/views/aboutUs.dart';
import 'package:hemantenterprises/views/autentication/registerauth.dart';
import 'package:hemantenterprises/views/brands/categories.dart';
import 'package:hemantenterprises/views/brands/model.dart';
import 'package:hemantenterprises/views/autentication/createaccount.dart';
import 'package:hemantenterprises/views/brands/home.dart';
import 'package:hemantenterprises/views/brands/listingpage.dart';
import 'package:hemantenterprises/views/autentication/login.dart';
import 'package:hemantenterprises/views/autentication/loginauth.dart';
import 'package:hemantenterprises/views/topbar/displayprofile.dart';
import 'package:hemantenterprises/views/topbar/editprofile.dart';
import 'package:hemantenterprises/views/cart/quote.dart';
import 'package:hemantenterprises/views/topbar/tollfreenumbers.dart';
import 'package:hemantenterprises/views/topbar/searchresult.dart';
import 'package:hemantenterprises/views/splash/splashcontext.dart';
import 'package:hemantenterprises/views/splash/splashscreen.dart';
import 'package:hemantenterprises/views/brands/product.dart';
import 'package:hemantenterprises/views/cart/thankyou.dart';



class AppRoutes {
  static const splash = '/splash';
  static const next = '/next';
  static const createAccount = '/createAccount';
  static const registerUserVerification = '/registerUserVerification';
  static const login = '/login';
  static const loginVerification = '/loginVerification';
  static const home = '/home';
  static const category = '/category';
  static const model = '/model';
  static const subCategory = '/subCategory';
  static const listingPage = '/listingPage';
  static const bottomNavigation= '/bottomNavigation';
  static const quote = '/quote';
  static const aboutUs = '/aboutUs';
  static const displayProfile = '/displayProfile';
  static const tollFree = '/tollFree';
  static const search = '/search';
  static const thankyou = '/thankyou';
  static const editProfile = '/editProfile';


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
     name: registerUserVerification, 
     page: ()=> RegisterUserVerification(),
    ),
    GetPage(
      name: login, 
      page: () => LoginScreen(),
    ),
    GetPage(
      name: loginVerification, 
      page: () => LoginVerification()
      ),
    GetPage(
      name: home, 
      page: () => HomeScreen()
      ),
    GetPage(
      name: category, 
      page: () => CategoryScreen()
      ),   
    GetPage(
      name: model, 
      page: () => ModelScreen()
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
      name: displayProfile, 
      page: () => DisplayProfile()
      ),
    GetPage(
      name: tollFree,     
      page: () => Tollfreenumbers()
      ),
    GetPage(
      name: thankyou, 
      page: () => ThankYouScreen()
      ),
    GetPage(
      name: editProfile, 
      page: () => EditProfile()
      ),
 

  ];
}
