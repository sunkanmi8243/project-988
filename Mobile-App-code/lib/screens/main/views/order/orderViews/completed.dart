import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerce/widgets/bottomsheets/leaveReview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../controller/home_state_controller.dart';

class Completed extends StatelessWidget {
  const Completed({super.key});

  @override
  Widget build(BuildContext context) {

  var number = NumberFormat("#,###");

  return GetBuilder<HomeStateController>(
      builder: (controller) {
        return (controller.completedOrders.isEmpty)?
        const Center(
          child: Text(
            "No completed orders",
            style: TextStyle(
              fontSize: 14,
              color: Color(0xff212121),
              fontFamily: "PlusJakartaSansBold"
            ),
          ),
        ):
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.separated(
            itemCount: controller.completedOrders.length,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 15,);
            },
            itemBuilder: (context, index) {
              return Container(
                width: Get.width,
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 20),
                      blurRadius: 32,
                      spreadRadius: -8,
                      color: const Color(0xff576F85).withOpacity(0.2)
                    )
                  ]
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: CachedNetworkImage(
                        imageUrl: controller.completedOrders[index]["order_items"][0]["product"]["image"],
                        height: 50,
                        width: 50,
                        progressIndicatorBuilder: (context, url, downloadProgress) => const Center(
                          child: Center(
                            child: SpinKitFadingCircle(
                              color: Color(0xff265682),
                              size: 30,
                            ),
                          )
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.completedOrders[index]["order_items"][0]["product"]["name"],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff212121),
                              fontFamily: "PlusJakartaSansBold"
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Text(
                            "Qty = ${controller.completedOrders[index]["order_items"][0]["quantity"]}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xff616161),
                              fontFamily: "PlusJakartaSansMed"
                            ),
                          ),
                          const SizedBox(height: 10,),
                          SvgPicture.asset(
                            "assets/images/completedButton.svg"
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                 "\$ ${number.format(int.parse(controller.completedOrders[index]["order_items"][0]["product"]["price"].toString().split(".").first))}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff212121),
                                  fontFamily: "PlusJakartaSansBold"
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  LeaveReview.showLeaveReview();
                                },
                                child: SvgPicture.asset(
                                  "assets/images/review.svg",
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }
    );
  
  }
}