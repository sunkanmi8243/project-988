import 'package:commerce/routes/app/app_route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../storage/secureStorage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  checkUser() async{
    String token = await LocalStorage().fetchUserToken();

    (token == "")?
    Get.toNamed(onboardingScreen):
    Get.toNamed(holder);

  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      (){
        checkUser();
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/splash.png"
            ),
            fit: BoxFit.cover
          )
        ),
      ),
    );
  }
}