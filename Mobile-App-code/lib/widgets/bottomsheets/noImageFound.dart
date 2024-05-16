import 'package:commerce/routes/app/app_route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NoImageFound {
  static show(context) {
    return showDialog(
      barrierDismissible: false,
      context: context, 
      builder:(context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child:  Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  "assets/images/success.svg",
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 10,),
                const Text(
                  "Update profile!",
                  style:  TextStyle(
                    color: Color(0xff292A2E),
                    fontSize: 24,
                    fontFamily: "PlusJakartaSansBold"
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Your firstname and lastnames are missing, please update your profile.",
                  textAlign: TextAlign.center,
                  style:  TextStyle(
                    color: Color(0xff7C7D82),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 56,
                  width: Get.width,
                  child: ElevatedButton(
                    onPressed: (){
                      Get.toNamed(fakeEditProfileScreen);
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
      },
    );
  }
}