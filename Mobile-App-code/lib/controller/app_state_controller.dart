import 'package:commerce/screens/main/views/cart/cart_view.dart';
import 'package:commerce/screens/main/views/home/home_view.dart';
import 'package:commerce/screens/main/views/profile/profile_view.dart';
import 'package:commerce/screens/main/views/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppStateController extends GetxController {

  // INSTANT VARIABLES
  final List<Map<String, dynamic>> _onboardingScreens = [
    {
      "icon": "assets/images/pick & pay.svg",
      "title": "Find the item you've been looking for",
      "subtitle": "Here you'll see rich varieties of goods, carefully classified for seamless browsing experience",
    },
    {
      "icon": "assets/images/shopping-basket.svg",
      "title": "Get those shopping bags filled",
      "subtitle": "Add any item you want to your cart or save it on your wishlist, so you don't miss it in your future purchase.",
    },
    {
      "icon": "assets/images/secure paymet.svg",
      "title": "Fast & Secure payment",
      "subtitle": "There are many payment options available to speed up and simplify your payment process.",
    },
  ];
  final List<Widget> _views = [
    HomeView(),
    const SearchView(),
    CartView(),
    ProfileView(),
  ];
  int _currentIndex = 0;
  int _currentView = 0;

  // GETTERS
  List get onboardingScreens => _onboardingScreens;
  List get views => _views;
  int get currentIndex => _currentIndex;
  int get currentView => _currentView;

  // SETTERS
  updatedCurrentIndex(value){
    _currentIndex = value;
    update();
  }
  updateCurrentView(value){
    _currentView = value;
    update();
  }
}