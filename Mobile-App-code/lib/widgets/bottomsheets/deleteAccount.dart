import 'package:commerce/controller/home_state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class DeleteAccountSheet {
  static show(context){
    Get.bottomSheet(
      GetBuilder<HomeStateController>(
        builder: (controller) {
          return Container(
            height: 190,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Delete Account",
                  style: TextStyle(
                    color: Color(0xff151515),
                    fontSize: 16,
                    fontFamily: "NunitoBold"
                  ),
                ),
                const SizedBox(height: 15,),
                const Text(
                  "Are you sure you want to delete your account. This action cannot be undone.",
                  style: TextStyle(
                    color: Color(0xff767676),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: (){
                            Get.back();
                          }, 
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            side: const BorderSide(
                              color: Color(0xff001F3F)
                            ),
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)
                            )
                          ),
                          child: const Text(
                            "No, Cancel",
                            style: TextStyle(
                              color: Color(0xff001F3F),
                              fontSize: 16,
                            ),
                          )
                        )
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: (){
                            controller.deletAccount();
                          }, 
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: const Color(0xff053969),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                            )
                          ),
                          child: (controller.isLoading)?
                          const Center(
                            child: SpinKitFadingCircle(
                              color: Colors.white,
                              size: 30,
                            ),
                          )
                          :
                          const Text(
                            "Yes, Delete",
                            style: TextStyle(
                              color: Color(0xff001F3F),
                              fontSize: 16,
                              fontFamily: "NunitoMed"
                            ),
                          )
                        ),
                      )
                    )
                  ],
                )
              ]
            ),
          );
        }
      ),
    );
  }
}