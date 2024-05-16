import 'package:commerce/screens/main/views/order/orderViews/completed.dart';
import 'package:commerce/screens/main/views/order/orderViews/ongoing.dart';
import 'package:commerce/screens/main/views/order/orderViews/pendingOrders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../../controller/home_state_controller.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({super.key});

  final HomeStateController _homeStateController = Get.find<HomeStateController>();

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _homeStateController.getOrders();
    });

    return GetBuilder<HomeStateController>(
      builder: (controller) {
        return LoadingOverlay(
          isLoading: controller.isItemLoading,
          progressIndicator: const SpinKitFadingCircle(
            color: Color(0xff053969),
            size: 50,
          ),
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              body: SizedBox(
                height: Get.height,
                width: Get.width,
                child: SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Get.back();
                                  },
                                  child: SvgPicture.asset(
                                    "assets/images/back.svg"
                                  ),
                                )
                              ],
                            ),
                            const Positioned(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "My Orders",
                                    style:  TextStyle(
                                      color: Color(0xff292A2E),
                                      fontSize: 18,
                                      fontFamily: "PlusJakartaSansMed"
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Get.back();
                                    },
                                    child: SvgPicture.asset(
                                      "assets/images/searchRight.svg"
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const TabBar(
                        isScrollable: true,
                        indicatorColor: Color(0xff101010),
                        labelColor: Color(0xff101010),
                        unselectedLabelColor: Color(0xff9E9E9E),
                        labelStyle: TextStyle(
                          fontSize: 16,
                          fontFamily: "PlusJakartaSansBold"
                        ),
                        unselectedLabelStyle: TextStyle(
                          fontSize: 16,
                          fontFamily: "PlusJakartaSansBold"
                        ),
                        tabs: [
                          Tab(
                            text: "Pending",
                          ),
                          Tab(
                            text: "Ongoing",
                          ),
                          Tab(
                            text: "Completed",
                          ),
                        ]
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: (controller.isLoading)?
                        const SpinKitFadingCircle(
                          color: Color(0xff265682),
                          size: 50,
                        ):
                        TabBarView(
                          children: [
                            PendingOrders(),
                            const Ongoing(),
                            const Completed(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}