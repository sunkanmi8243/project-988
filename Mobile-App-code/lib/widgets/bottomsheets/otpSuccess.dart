import 'package:commerce/controller/auth_state_controller.dart';
import 'package:commerce/routes/app/app_route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class OtpSuccess {
  static showOtpSuccess() {
    Get.bottomSheet(
      GetBuilder<AuthStateController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 4,
                      width: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withOpacity(0.2)
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  SvgPicture.asset(
                    "assets/images/success.svg"
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    "Congratulations!",
                    style:  TextStyle(
                      color: Color(0xff292A2E),
                      fontSize: 24,
                      fontFamily: "PlusJakartaSansBold"
                    ),
                  ),
                  const SizedBox(height: 15,),
                  const Text(
                    "Your account is ready to use. You will be redirected to the Homepage in a few seconds.",
                    textAlign: TextAlign.center,
                    style:  TextStyle(
                      color: Color(0xff7C7D82),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 25,),
                  SizedBox(
                    height: 56,
                    width: Get.width,
                    child: ElevatedButton(
                      onPressed: (){
                        Get.toNamed(loginScreen);
                      }, 
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        backgroundColor: const Color(0xff053969)
                      ),
                      child: const Text(
                        "Continue",
                        style:  TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: "PlusJakartaSansMed"
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
      isScrollControlled: true
    );
  }
}