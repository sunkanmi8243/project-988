import 'package:commerce/routes/app/app_route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../controller/home_state_controller.dart';

class AddressScreen extends StatelessWidget {
   AddressScreen({super.key});

  final HomeStateController _homeStateController = Get.find<HomeStateController>();

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _homeStateController.getAllAddress();
    });

    return GetBuilder<HomeStateController>(
      builder: (controller) {
        return Scaffold(
          body: 
          SizedBox(
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
                                "Address",
                                style:  TextStyle(
                                  color: Color(0xff292A2E),
                                  fontSize: 18,
                                  fontFamily: "PlusJakartaSansBold"
                                ),
                              ),
        
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25,),
                  Expanded(
                    flex: 9,
                    child: (controller.isLoading)?
                    const SpinKitFadingCircle(
                      color: Color(0xff265682),
                      size: 50,
                    ):(controller.addresses.isEmpty)?
                    const Center(
                      child: Text(
                        "No address available",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff212121),
                          fontFamily: "PlusJakartaSansBold"
                        ),
                      ),
                    ):
                    Padding(
                      padding:  const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: controller.addresses.map((address) {
                          return _listTile(
                            address["name"], 
                            address["full_address"], 
                            address["phone"]
                          );
                        }).toList()
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          height: 56,
                          width: Get.width,
                          child: ElevatedButton(
                            onPressed: (){
                              Get.toNamed(selectAddressScreen);
                            }, 
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              backgroundColor: const Color(0xff053969)
                            ),
                            child:
                            const Text(
                              "Add New Address",
                              style:  TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: "PlusJakartaSansMed"
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ),
          ),
        );
      }
    );
  }

  Container _listTile(title, subtitle, number) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xffEDEDED)
        ),
        borderRadius: BorderRadius.circular(16)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style:  const TextStyle(
                      color: Color(0xff292A2E),
                      fontSize: 14,
                      fontFamily: "PlusJakartaSansMed"
                    ),
                  ),
                ],  
              ),
              SvgPicture.asset(
                "assets/images/default_badge.svg",
              )
            ],
          ),
          const SizedBox(height: 20,),
          Row(
            children: [
             Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subtitle,
                      style: const  TextStyle(
                        color: Color(0xff292A2E),
                        fontSize: 14,
                        fontFamily: "PlusJakartaSansBold"
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      number,
                      style:  const TextStyle(
                        color: Color(0xff292A2E),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    "assets/images/Map.png"
                  ),
                ),
              )
            ],
          )
        ],
      )
    );
  }
}