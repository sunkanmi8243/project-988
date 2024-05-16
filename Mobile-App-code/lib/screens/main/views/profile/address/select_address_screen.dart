import 'package:commerce/controller/home_state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SelectAddressScreen extends StatelessWidget {
   SelectAddressScreen({super.key});

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    FlutterTts flutterTts = FlutterTts();
    speak() async{
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(
        "Your profile name is, , there are different settings here including Address, Payment methods, Notifications, Account security. You can also invite friends, check out our privacy policy and help center. If you wish you can log out too."
      );
    }


    return Scaffold(
      body: GetBuilder<HomeStateController>(
        builder: (controller) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            child: SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
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
                                  "Select Address",
                                  style:  TextStyle(
                                    color: Color(0xff292A2E),
                                    fontSize: 18,
                                    fontFamily: "PlusJakartaSansBold"
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: (){
                                  speak();
                                },
                                child: SvgPicture.asset(
                                  "assets/images/right.svg"
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Expanded(
                      flex: 9,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 30,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 378,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(16),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          "assets/images/big_map.png"
                                        ),
                                        fit: BoxFit.cover
                                      )
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  const Text(
                                    "Select your location from the map",
                                    style:  TextStyle(
                                      color: Color(0xff292A2E),
                                      fontSize: 18,
                                      fontFamily: "PlusJakartaSansBold"
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  const Text(
                                    "Move the pin on the map to find your location and select the delivery address",
                                    style:  TextStyle(
                                      color: Color(0xff7C7D82),
                                      fontSize: 14,
                                      fontFamily: "PlusJakartaSansMed"
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Address Name",
                                        style:  TextStyle(
                                          color: Color(0xff7C7D82),
                                          fontSize: 12,
                                          fontFamily: "PlusJakartaSansMed"
                                        ),
                                      ),
                                      const SizedBox(height: 7,),
                                      TextFormField(
                                        onChanged: (value) {
                                          controller.updateAddressName(value);
                                        },
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                              color: Color(0xffEAEAEA)
                                            )
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                              color: Color(0xffEAEAEA)
                                            )
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                        
                                          ),
                                          hintText: "e.g Office",
                                          hintStyle: const TextStyle(
                                            color: Color(0xffBCBDC0),
                                            fontSize: 16,
                                          ),
                                        ),
                                        validator: ValidationBuilder().build(),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 20,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Street Address",
                                        style:  TextStyle(
                                          color: Color(0xff7C7D82),
                                          fontSize: 12,
                                          fontFamily: "PlusJakartaSansMed"
                                        ),
                                      ),
                                      const SizedBox(height: 7,),
                                      TextFormField(
                                        onChanged: (value) {
                                          controller.updateAddressDetails(value);
                                        },
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                              color: Color(0xffEAEAEA)
                                            )
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                              color: Color(0xffEAEAEA)
                                            )
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                        
                                          ),
                                          suffixIcon: const Icon(
                                            Iconsax.location,
                                            color: Color(0xff053969),
                                          ),
                                          hintText: "Address Detail",
                                          hintStyle: const TextStyle(
                                            color: Color(0xffBCBDC0),
                                            fontSize: 16,
                                          ),
                                        ),
                                        validator: ValidationBuilder().build(),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 20,),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "City",
                                              style:  TextStyle(
                                                color: Color(0xff7C7D82),
                                                fontSize: 12,
                                                fontFamily: "PlusJakartaSansMed"
                                              ),
                                            ),
                                            const SizedBox(height: 7,),
                                            TextFormField(
                                              onChanged: (value) {
                                                controller.updateCity(value);
                                              },
                                              decoration: InputDecoration(
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                  borderSide: const BorderSide(
                                                    color: Color(0xffEAEAEA)
                                                  )
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                  borderSide: const BorderSide(
                                                    color: Color(0xffEAEAEA)
                                                  )
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                focusedErrorBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                              
                                                ),
                                                hintText: "City",
                                                hintStyle: const TextStyle(
                                                  color: Color(0xffBCBDC0),
                                                  fontSize: 16,
                                                ),
                                              ),
                                              validator: ValidationBuilder().build(),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 20,),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "State",
                                              style:  TextStyle(
                                                color: Color(0xff7C7D82),
                                                fontSize: 12,
                                                fontFamily: "PlusJakartaSansMed"
                                              ),
                                            ),
                                            const SizedBox(height: 7,),
                                            TextFormField(
                                              onChanged: (value) {
                                                controller.updateState(value);
                                              },
                                              decoration: InputDecoration(
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                  borderSide: const BorderSide(
                                                    color: Color(0xffEAEAEA)
                                                  )
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                  borderSide: const BorderSide(
                                                    color: Color(0xffEAEAEA)
                                                  )
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                focusedErrorBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                              
                                                ),
                                                hintText: "State",
                                                hintStyle: const TextStyle(
                                                  color: Color(0xffBCBDC0),
                                                  fontSize: 16,
                                                ),
                                              ),
                                              validator: ValidationBuilder().build(),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Phone Number",
                                        style:  TextStyle(
                                          color: Color(0xff7C7D82),
                                          fontSize: 12,
                                          fontFamily: "PlusJakartaSansMed"
                                        ),
                                      ),
                                      const SizedBox(height: 7,),
                                      IntlPhoneField(
                                        initialCountryCode: "NG",
                                        disableLengthCheck: true,
                                        onChanged: (value) {
                                          controller.updateAddressPhone(value.completeNumber);
                                        },
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                              color: Color(0xffEAEAEA)
                                            )
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide: const BorderSide(
                                              color: Color(0xffEDEDED)
                                            )
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          // contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                                        ),
                                        
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20,),
                                ],
                              ),
                            ),
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
                              (_formKey.currentState!.validate())?
                              controller.addAddress()
                              :
                              AutovalidateMode.disabled;
                              }, 
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                backgroundColor: const Color(0xff053969)
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
                                "Add Address",
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
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}