import 'package:commerce/controller/home_state_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterBottomSheet {
  static showFilterBottomSheet(){
    Get.bottomSheet(
      GetBuilder<HomeStateController>(
        builder: (controller) {
          return Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: const BoxDecoration(
              color: Color(0xffF5F5F5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
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
                const Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                        "Filter",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff212121),
                          fontFamily: "PlusJakartaSansBold"
                        ),
                      ),
                       Text(
                        "Reset",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff1B5EC9),
                          fontFamily: "PlusJakartaSansBold"
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                const Divider(
                  color: Color(0xffEEEEEE),
                  thickness: 3,
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Price range",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff292A2E),
                          fontFamily: "PlusJakartaSansBold"
                        ),
                      ),
                      const SizedBox(height: 10,),
                      RangeSlider(
                        values: controller.selectedRange, 
                        min: 100,
                        max: 2000,
                        labels: RangeLabels(
                          "\$ ${controller.selectedRange.start}", 
                          "\$ ${controller.selectedRange.end}", 
                        ),
                        onChanged:(value) {
                          controller.updateRange(value);
                        },
                        activeColor: const Color(0xffFF9C44),
                        inactiveColor: const Color(0xffF1F1F1),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Sort by",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff292A2E),
                          fontFamily: "PlusJakartaSansBold"
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 44,
                              decoration: BoxDecoration(
                                color: const Color(0xffFF9C44),
                                borderRadius: BorderRadius.circular(50)
                              ),
                              child: const Center(
                                child: Text(
                                  "New Arrived",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontFamily: "PlusJakartaSansMed"
                                  ),
                                ),
                              ),
                            )
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              height: 44,
                              decoration: BoxDecoration(
                                // color: const Color(0xffFF9C44),
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: const Color(0xffEAEAEA))
                              ),
                              child: const Center(
                                child: Text(
                                  "Higher price",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff292A2E),
                                    fontFamily: "PlusJakartaSansMed"
                                  ),
                                ),
                              ),
                            )
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 44,
                              decoration: BoxDecoration(
                                // color: const Color(0xffFF9C44),
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: const Color(0xffEAEAEA))
                              ),
                              child: const Center(
                                child: Text(
                                  "Lower price",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff292A2E),
                                    fontFamily: "PlusJakartaSansMed"
                                  ),
                                ),
                              ),
                            )
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              height: 44,
                              decoration: BoxDecoration(
                                // color: const Color(0xffFF9C44),
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: const Color(0xffEAEAEA))
                              ),
                              child: const Center(
                                child: Text(
                                  "Discount",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff292A2E),
                                    fontFamily: "PlusJakartaSansMed"
                                  ),
                                ),
                              ),
                            )
                          ),
                        ],
                      ),
                      const SizedBox(height: 30,),
                      SizedBox(
                        height: 56,
                        width: Get.width,
                        child: ElevatedButton(
                          onPressed: (){
                            // _appStateController.updateCurrentView(0);
                          }, 
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            backgroundColor: const Color(0xff053969)
                          ),
                          child: const Text(
                            "Apply filter",
                            style:  TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: "PlusJakartaSansMed"
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      ),
      isScrollControlled: true
    );
  }
}