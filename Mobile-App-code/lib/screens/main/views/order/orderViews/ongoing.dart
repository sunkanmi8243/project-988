import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerce/controller/home_state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Ongoing extends StatelessWidget {
  const Ongoing({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<HomeStateController>(
      builder: (controller) {
        return (controller.ongoingOrders.isEmpty)?
        const Center(
          child: Text(
            "No ongoing orders",
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
            itemCount: controller.ongoingOrders.length,
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
                        imageUrl: controller.ongoingOrders[index]["order_items"][0]["product"]["image"],
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
                            controller.ongoingOrders[index]["order_items"][0]["product"]["name"],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff212121),
                              fontFamily: "PlusJakartaSansBold"
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Text(
                            "Qty = ${controller.ongoingOrders[index]["order_items"][0]["quantity"]}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xff616161),
                              fontFamily: "PlusJakartaSansMed"
                            ),
                          ),
                          const SizedBox(height: 10,),
                          SvgPicture.asset(
                            "assets/images/inDeliveryButton.svg"
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$ ${controller.ongoingOrders[index]["order_items"][0]["product"]["price"]}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff212121),
                                  fontFamily: "PlusJakartaSansBold"
                                ),
                              ),
                              SvgPicture.asset(
                                "assets/images/track.svg"
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