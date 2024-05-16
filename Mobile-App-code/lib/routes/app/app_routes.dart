
import 'package:commerce/routes/app/app_route_names.dart';
import 'package:commerce/screens/auth/createAccountScreen.dart';
import 'package:commerce/screens/auth/emailVerificationScreen.dart';
import 'package:commerce/screens/auth/loginScreen.dart';
import 'package:commerce/screens/auth/otpVerification.dart';
import 'package:commerce/screens/auth/resetPasswordScreen.dart';
import 'package:commerce/screens/main/holder/holder_screen.dart';
import 'package:commerce/screens/main/views/details/product_detail_screen.dart';
import 'package:commerce/screens/main/views/home/notification_screen.dart';
import 'package:commerce/screens/main/views/home/wish_list_screen.dart';
import 'package:commerce/screens/main/views/more/scan_product_screen.dart';
import 'package:commerce/screens/main/views/order/orderScreen.dart';
import 'package:commerce/screens/main/views/order/order_details.dart';
import 'package:commerce/screens/main/views/order/reviews.dart';
import 'package:commerce/screens/main/views/profile/address/address_order.dart';
import 'package:commerce/screens/main/views/profile/address/address_screen.dart';
import 'package:commerce/screens/main/views/profile/address/select_address_screen.dart';
import 'package:commerce/screens/main/views/profile/payment/add_new_card_screen.dart';
import 'package:commerce/screens/main/views/profile/payment/payment_method_screen.dart';
import 'package:commerce/screens/main/views/profile/privacy-policy/privacy-policy.dart';
import 'package:commerce/screens/main/views/profile/profile_view/edit_profile_view.dart';
import 'package:commerce/screens/main/views/profile/profile_view/fakeEditProfileScreen.dart';
import 'package:commerce/screens/main/views/search/searchedView.dart';
import 'package:commerce/screens/main/views/search/searchedView2.dart';
import 'package:commerce/screens/onboarding/onboardingScreen.dart';
import 'package:commerce/screens/splash/splash.dart';
import 'package:get/get.dart';

import '../../screens/main/views/home/cart_screen.dart';

List<GetPage> getPages = [

  // splash
  GetPage(
    name: splash, 
    page: ()=> const SplashScreen()
  ),

  // ONBOARDING
  GetPage(
    name: onboardingScreen, 
    page: ()=> OnboardingScreen()
  ),

  // AUTH
  GetPage(
    name: loginScreen, 
    page: ()=> LoginScreen()
  ),
  GetPage(
    name: createAccountScreen, 
    page: ()=> CreateAccountScreen()
  ),
  GetPage(
    name: otpVerification, 
    page: ()=> const OtpVerificationScreen()
  ),
  GetPage(
    name: emailVerification, 
    page: ()=> const EmailVerificationScreen()
  ),
  GetPage(
    name: resetPasswordScreen, 
    page: ()=> ResetPasswordScreen()
  ),

  // MAIN
  GetPage(
    name: holder, 
    page: ()=> HolderScreen()
  ),
  GetPage(
    name: cartScreen, 
    page: ()=> CartScreen()
  ),
  GetPage(
    name: detailScreen, 
    page: ()=> ProductDetailScreen()
  ),
  GetPage(
    name: wishListScreen, 
    page: ()=> const WishListScreen()
  ),
  GetPage(
    name: orderScreen, 
    page: ()=> OrderScreen()
  ),
  GetPage(
    name: orderDetailsScreen, 
    page: ()=> const OrderDetails()
  ),
  GetPage(
    name: reviewScreen, 
    page: ()=> const ReviewScreen()
  ),
  GetPage(
    name: searchedProductScreen, 
    page: ()=> SearchedView()
  ),
  GetPage(
    name: notificationScreen, 
    page: ()=> const NotificationScreen()
  ),
  GetPage(
    name: editProfileScreen, 
    page: ()=> EditProfileScreen()
  ),
  GetPage(
    name: fakeEditProfileScreen, 
    page: ()=> FakeEditProfileScreen()
  ),
  GetPage(
    name: scanProductScreen, 
    page: ()=> const ScanProductScreen()
  ),
  GetPage(
    name: paymentMethodScreen, 
    page: ()=> PaymentMethodScreen()
  ),
  GetPage(
    name: addNewCardScreen, 
    page: ()=> const AddNewCardScreen()
  ),
  GetPage(
    name: addressScreen, 
    page: ()=>  AddressScreen()
  ),
  GetPage(
    name: addressOrderScreen, 
    page: ()=>  AddressOrderScreen()
  ),
  GetPage(
    name: selectAddressScreen, 
    page: ()=>  SelectAddressScreen()
  ),
  GetPage(
    name: searchedProductScreen2, 
    page: ()=> SearchedView2()
  ),
  GetPage(
    name: privacyPolicyScreen, 
    page: ()=> PrivacyPolicyScreen()
  ),
];