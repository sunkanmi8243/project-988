import 'package:card_swiper/card_swiper.dart';
import 'package:commerce/controller/app_state_controller.dart';
import 'package:commerce/routes/app/app_route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final AppStateController _appStateController = Get.put(AppStateController());

  @override
  Widget build(BuildContext context) {

    
    return GetBuilder<AppStateController>(
      builder: (controller) {
        return Scaffold(
          body: SizedBox(
            height: Get.height,
            width: Get.width,
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.toNamed(loginScreen);
                            },
                            child: const Text(
                              "Skip",
                              style: TextStyle(
                                color: Color(0xff292A2E),
                                fontSize: 14
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Swiper(
                      itemCount: controller.onboardingScreens.length,
                      loop: false,
                      onIndexChanged: (value) {
                        controller.updatedCurrentIndex(value);
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  controller.onboardingScreens[controller.currentIndex]["icon"]
                                ),
                                const SizedBox(height: 20,),
                                Text(
                                  controller.onboardingScreens[controller.currentIndex]["title"],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xff292A2E),
                                    fontSize: 28,
                                    fontFamily: "PlusJakartaSansBold"
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                Text(
                                  controller.onboardingScreens[controller.currentIndex]["subtitle"],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xff7C7D82),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: CircularStepProgressIndicator(
                        height: 94,
                        width: 94,
                        stepSize: 3.0,
                        totalSteps: controller.onboardingScreens.length,
                        currentStep: controller.currentIndex + 1,
                        padding: 0,
                        selectedColor: const Color(0xff053969),
                        unselectedColor: const Color(0xff053969).withOpacity(0.1),
                        child: Center(
                          child: FloatingActionButton(
                            shape: const CircleBorder(),
                            onPressed: (){
                              (controller.currentIndex == 0)?
                              controller.updatedCurrentIndex(1)
                              :
                              (controller.currentIndex == 1)?
                              controller.updatedCurrentIndex(2)
                              :
                              Get.toNamed(loginScreen);
                            },
                            elevation: 0,
                            backgroundColor: const Color(0xff053969),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}