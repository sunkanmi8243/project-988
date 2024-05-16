import 'package:commerce/controller/home_state_controller.dart';
import 'package:commerce/routes/app/app_route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LanguageSheet {
  static showLanguageSheet() async{

    Get.bottomSheet(
      GetBuilder<HomeStateController>(
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
                    "Select Language",
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
                          controller.updateSelectedLanguage("id");
                        },
                        child: Container(
                          width: Get.width,
                          padding: const EdgeInsets.all(17),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: (controller.selectedLanguage == "id")?
                              const Color(0xffFF9C44)
                              :
                              const Color(0xffEAEAEA)
                            )
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 32,
                                width: 32,
                                decoration: const BoxDecoration(
                                  color: Color(0xffF3F6FB),
                                  shape: BoxShape.circle
                                ),
                                child: const Center(
                                  child:  Text(
                                    "🇮🇩"
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                "Indonesia",
                                style:  TextStyle(
                                  color: Color(0xff292A2E),
                                  fontSize: 14,
                                  fontFamily: "PlusJakartaSansBold"
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      (controller.selectedLanguage == "id")?
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
                          controller.updateSelectedLanguage("en");
                        },
                        child: Container(
                          width: Get.width,
                          padding: const EdgeInsets.all(17),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: (controller.selectedLanguage == "en")?
                                  const Color(0xffFF9C44)
                                      :
                                  const Color(0xffEAEAEA)
                              )
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 32,
                                width: 32,
                                decoration: const BoxDecoration(
                                    color: Color(0xffF3F6FB),
                                    shape: BoxShape.circle
                                ),
                                child: const Center(
                                  child: Text(
                                      "🇺🇸"
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                "English (US)",
                                style:  TextStyle(
                                    color: Color(0xff292A2E),
                                    fontSize: 14,
                                    fontFamily: "PlusJakartaSansBold"
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      (controller.selectedLanguage == "en")?
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
                          controller.updateSelectedLanguage("th");
                        },
                        child: Container(
                          width: Get.width,
                          padding: const EdgeInsets.all(17),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: (controller.selectedLanguage == "th")?
                                  const Color(0xffFF9C44)
                                      :
                                  const Color(0xffEAEAEA)
                              )
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 32,
                                width: 32,
                                decoration: const BoxDecoration(
                                    color: Color(0xffF3F6FB),
                                    shape: BoxShape.circle
                                ),
                                child: const Center(
                                  child:  Text(
                                      "🇹🇭"
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                "Thailand",
                                style:  TextStyle(
                                    color: Color(0xff292A2E),
                                    fontSize: 14,
                                    fontFamily: "PlusJakartaSansBold"
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      (controller.selectedLanguage == "th")?
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
                          controller.updateSelectedLanguage("zh-cn");
                        },
                        child: Container(
                          width: Get.width,
                          padding: const EdgeInsets.all(17),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: (controller.selectedLanguage == "zh-cn")?
                                  const Color(0xffFF9C44)
                                      :
                                  const Color(0xffEAEAEA)
                              )
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 32,
                                width: 32,
                                decoration: const BoxDecoration(
                                    color: Color(0xffF3F6FB),
                                    shape: BoxShape.circle
                                ),
                                child: const Center(
                                  child:  Text(
                                      "🇨🇳"
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                "Chinese",
                                style:  TextStyle(
                                    color: Color(0xff292A2E),
                                    fontSize: 14,
                                    fontFamily: "PlusJakartaSansBold"
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      (controller.selectedLanguage == "zh-cn")?
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
                        Get.back();
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