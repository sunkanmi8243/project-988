import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controller/home_state_controller.dart';

class OrderCard extends StatefulWidget {

  var id;
  var index;

  OrderCard({super.key, required this.id, required this.index});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  final HomeStateController _homeStateController = Get.find<HomeStateController>();


  @override
  void initState(){
    super.initState();
      _homeStateController.getOrderDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<HomeStateController>(
      builder: (controller) {
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
                child: Image.asset(
                  "assets/images/shoe.png"
                ),
              ),
              const SizedBox(width: 20,),
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.completedCardDetails[widget.index]["id"].toString(),
                      // widget.id.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff212121),
                        fontFamily: "PlusJakartaSansBold"
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Text(
                      "Qty = 5",
                      style:  TextStyle(
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
                        const Text(
                          "Qty = 5",
                          style:  TextStyle(
                            fontSize: 14,
                            color: Color(0xff212121),
                            fontFamily: "PlusJakartaSansBold"
                          ),
                        ),
                        SvgPicture.asset(
                          "assets/images/review.svg",
                        )
                      ],
                    ),
                  ],
                )
              ),
            ],
          ),
        );
      }
    );
  }
}