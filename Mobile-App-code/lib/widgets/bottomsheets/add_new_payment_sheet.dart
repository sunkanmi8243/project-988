import 'package:commerce/controller/auth_state_controller.dart';
import 'package:commerce/routes/app/app_route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddNewPaymentSheet {
  static showAddNewPaymentSheet() async{

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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(height: 20,),
                  const Text(
                    "Add new payment method",
                    style:  TextStyle(
                      color: Color(0xff292A2E),
                      fontSize: 18,
                      fontFamily: "PlusJakartaSansBold"
                    ),
                  ),
                  const SizedBox(height: 25,),
                  Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.updateSelectedMethod("1");
                        },
                        child: Container(
                          width: Get.width,
                          padding: const EdgeInsets.all(17),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: (controller.selectedMethod == "1")?
                              const Color(0xffFF9C44)
                              :
                              const Color(0xffEAEAEA)
                            )
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Iconsax.card
                              ),
                               SizedBox(width: 12),
                               Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Credit or Debit Card",
                                    style:  TextStyle(
                                      color: Color(0xff292A2E),
                                      fontSize: 14,
                                      fontFamily: "PlusJakartaSansBold"
                                    ),
                                  ),
                                  SizedBox(height: 15,),
                                  Text(
                                    "Pay with your Visa or Mastercard ",
                                    style:  TextStyle(
                                      color: Color(0xff7C7D82),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      (controller.selectedMethod == "1")?
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SvgPicture.asset(
                            "assets/images/check.svg"
                          ),
                        ),
                      )
                      :
                      const SizedBox()
                    ],
                  ),
                  const SizedBox(height: 15,),
                  Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.updateSelectedMethod("2");
                        },
                        child: Container(
                          width: Get.width,
                          padding: const EdgeInsets.all(17),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: (controller.selectedMethod == "2")?
                              const Color(0xffFF9C44)
                              :
                              const Color(0xffEAEAEA)
                            )
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/images/paypal.svg"
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                "Paypal",
                                style: TextStyle(
                                  color: Color(0xff292A2E),
                                  fontSize: 14,
                                  fontFamily: "PlusJakartaSansBold"
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      (controller.selectedMethod == "2")?
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SvgPicture.asset(
                            "assets/images/check.svg"
                          ),
                        ),
                      )
                      :
                      const SizedBox()
                    ],
                  ),
                  const SizedBox(height: 15,),
                  Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.updateSelectedMethod("3");
                        },
                        child: Container(
                          width: Get.width,
                          padding: const EdgeInsets.all(17),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: (controller.selectedMethod == "3")?
                              const Color(0xffFF9C44)
                              :
                              const Color(0xffEAEAEA)
                            )
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/images/apple-pay.svg"
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                "Apple Pay",
                                style: TextStyle(
                                  color: Color(0xff292A2E),
                                  fontSize: 14,
                                  fontFamily: "PlusJakartaSansBold"
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      (controller.selectedMethod == "3")?
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SvgPicture.asset(
                            "assets/images/check.svg"
                          ),
                        ),
                      )
                      :
                      const SizedBox()
                    ],
                  ),
                  const SizedBox(height: 25,),
                  SizedBox(
                    height: 56,
                    width: Get.width,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(addNewCardScreen);
                      }, 
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        backgroundColor: const Color(0xff053969)
                      ),
                      child:  (controller.isLoading)?
                          const Center(
                            child: SpinKitFadingCircle(
                              color: Colors.white,
                              size: 30,
                            ),
                          )
                          :
                      const Text(
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