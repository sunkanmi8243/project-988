import 'package:commerce/controller/auth_state_controller.dart';
import 'package:commerce/storage/secureStorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ForgotPassword {
  static showForgotPassword() async{

    String email = await LocalStorage().fetchEmail();

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
                    "Forget password",
                    style:  TextStyle(
                      color: Color(0xff292A2E),
                      fontSize: 32,
                      fontFamily: "PlusJakartaSansBold"
                    ),
                  ),
                  const SizedBox(height: 15,),
                  const Text(
                    "Select which contact details should we use to reset your password",
                    style:  TextStyle(
                      color: Color(0xff7C7D82),
                      fontSize: 14,
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
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/images/whatsapp_blue.svg"
                              ),
                              const SizedBox(width: 12),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Send via WhatsApp",
                                    style:  TextStyle(
                                      color: Color(0xff7C7D82),
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(
                                    "+62812 788 61 1672",
                                    style:  TextStyle(
                                      color: Color(0xff292A2E),
                                      fontSize: 14,
                                      fontFamily: "PlusJakartaSansBold"
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
                                "assets/images/mail_blue.svg"
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Send via Email",
                                    style:  TextStyle(
                                      color: Color(0xff7C7D82),
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(
                                    email,
                                    style:  const TextStyle(
                                      color: Color(0xff292A2E),
                                      fontSize: 14,
                                      fontFamily: "PlusJakartaSansBold"
                                    ),
                                  ),
                                ],
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
                  const SizedBox(height: 25,),
                  SizedBox(
                    height: 56,
                    width: Get.width,
                    child: ElevatedButton(
                      onPressed: () async{
                        String email = await LocalStorage().fetchEmail();
                        controller.forgotPassword(email);
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