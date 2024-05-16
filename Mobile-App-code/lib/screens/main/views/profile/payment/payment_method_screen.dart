import 'package:commerce/controller/auth_state_controller.dart';
import 'package:commerce/widgets/bottomsheets/add_new_payment_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class PaymentMethodScreen extends StatelessWidget {
   PaymentMethodScreen({super.key});

  final AuthStateController _authStateController = Get.put(AuthStateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            "Payment Method",
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _listTile("assets/images/mastercard.svg", "MasterCard", "**** **** 0783 7873"),
                      const SizedBox(height: 20,),
                      _listTile("assets/images/paypal.svg", "Paypal", "**** **** 0582 4672"),
                      const SizedBox(height: 20,),
                      _listTile("assets/images/apple-pay.svg", "Apple Pay", "**** **** 0582 4672"),
                    ],
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
                          AddNewPaymentSheet.showAddNewPaymentSheet();
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
                          "Add New Payment",
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

  Container _listTile(icon, title, subtitle) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xffEDEDED)
        ),
        borderRadius: BorderRadius.circular(16)
      ),
      child: ListTile(
        leading: SvgPicture.asset(
          icon
        ),
        title: Text(
          title,
           style: const TextStyle(
            color: Color(0xff292A2E),
            fontSize: 14,
            fontFamily: "PlusJakartaSansBold"
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Color(0xff7C7D82),
            fontSize: 14,
          ),
        ),
        trailing: const Icon(
          Iconsax.arrow_right_3,
          size: 20,
          color: Color(0xff053969),
        ),
      ),
    );
  }
}