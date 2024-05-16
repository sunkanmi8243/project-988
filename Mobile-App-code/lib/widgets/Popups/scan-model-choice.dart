import 'package:commerce/controller/home_state_controller.dart';
import 'package:commerce/routes/app/app_route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ScanModelChoice {
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
          content: GetBuilder<HomeStateController>(
            builder: (controller) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Select Model",
                      style:  TextStyle(
                        color: Color(0xff292A2E),
                        fontSize: 24,
                        fontFamily: "PlusJakartaSansBold"
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: List.generate(controller.models.length, (index) => RadioListTile(
                        value: controller.models[index], 
                        groupValue: controller.selectedModel, 
                        onChanged: (value) {
                          controller.updateSelectedModel(value);
                        },
                        title: Text(
                          controller.models[index]
                        ),
                        )
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 56,
                      width: Get.width,
                      child: ElevatedButton(
                        onPressed: (){
                          Get.toNamed(
                            scanProductScreen,
                            arguments: controller.selectedModel
                          );
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
              );
            }
          ),
        );
      },
    );
  }
}