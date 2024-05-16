import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../controller/home_state_controller.dart';

class PrivacyPolicyScreen extends StatelessWidget {
   PrivacyPolicyScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return GetBuilder<HomeStateController>(
      builder: (controller) {
        return Scaffold(
          body: 
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  "Privacy policy",
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
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "1. Types of Data We Collect",
                                style:  TextStyle(
                                  color: Color(0xff292A2E),
                                  fontSize: 18,
                                  fontFamily: "PlusJakartaSansBold"
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                                style:  TextStyle(
                                  color: Color(0xff7C7D82),
                                  fontSize: 14,
                                  fontFamily: "PlusJakartaSansMed"
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "2. Use of Your Personal Data",
                                style:  TextStyle(
                                  color: Color(0xff292A2E),
                                  fontSize: 18,
                                  fontFamily: "PlusJakartaSansBold"
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                "Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).\n\nThe generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
                                style:  TextStyle(
                                  color: Color(0xff7C7D82),
                                  fontSize: 14,
                                  fontFamily: "PlusJakartaSansMed"
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "3. Disclosure of Your Personal Data",
                                style:  TextStyle(
                                  color: Color(0xff292A2E),
                                  fontSize: 18,
                                  fontFamily: "PlusJakartaSansBold"
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.',
                                style:  TextStyle(
                                  color: Color(0xff7C7D82),
                                  fontSize: 14,
                                  fontFamily: "PlusJakartaSansMed"
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ),
          ),
        );
      }
    );
  }
}