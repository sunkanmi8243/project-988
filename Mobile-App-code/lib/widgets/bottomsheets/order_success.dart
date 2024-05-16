import 'package:commerce/routes/app/app_route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class OrderSuccess {
  static show() {
    Get.bottomSheet(
      Padding(
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
                "assets/images/order-success.svg"
              ),
              const SizedBox(height: 20,),
              const Text(
                "Order Successful!",
                style:  TextStyle(
                  color: Color(0xff292A2E),
                  fontSize: 24,
                  fontFamily: "PlusJakartaSansBold"
                ),
              ),
              const SizedBox(height: 15,),
              const Text(
                "You have successfully made order",
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
                    Get.toNamed(orderScreen);
                  }, 
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    backgroundColor: const Color(0xff053969)
                  ),
                  child: const Text(
                    "View Order",
                    style:  TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: "PlusJakartaSansMed"
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              SizedBox(
                height: 56,
                width: Get.width,
                child: ElevatedButton(
                  onPressed: (){
                    Get.offAllNamed(holder);
                  }, 
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    side: const BorderSide(
                      color: Color(0xffEAEAEA)
                    )
                  ),
                  child: const Text(
                    "Back to Home",
                    style:  TextStyle(
                      color: Color(0xff053969),
                      fontSize: 16,
                      fontFamily: "PlusJakartaSansMed"
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true
    );
  }
}