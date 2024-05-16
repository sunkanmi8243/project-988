import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNewCardScreen extends StatelessWidget {
  const AddNewCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            color: const Color(0xff2A3647),
          ),
          Positioned(
            right: 0,
            child: Image.asset(
              "assets/images/Gradient.png",
            ),
          ),
          Positioned(
            left: 0,
            child: Image.asset(
              "assets/images/Gradient-1.png",
            ),
          ),
          Positioned(
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
                                "assets/images/back_white.svg"
                              ),
                            )
                          ],
                        ),
                        const Positioned(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Add New Card",
                                style:  TextStyle(
                                  color: Colors.white,
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
                ],
              )
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: 700,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 583,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        )
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Container(
                          height: 215,
                          width: double.infinity,
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: const DecorationImage(
                              image: AssetImage(
                                "assets/images/card_background.png"
                              ),
                              fit: BoxFit.cover
                            )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "SoCard",
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(height: 30,),
                              Text(
                                "2727  8907  1278  3726",
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Card holder name",
                                            style: GoogleFonts.outfit(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                          const SizedBox(height: 5,),
                                          Text(
                                            "Bryan Adam",
                                            style: GoogleFonts.outfit(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 30,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Expiry date",
                                            style: GoogleFonts.outfit(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                          const SizedBox(height: 5,),
                                          Text(
                                            "10 / 26",
                                            style: GoogleFonts.outfit(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SvgPicture.asset(
                                    "assets/images/card_mastercard.svg"
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30,),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Card Name",
                                    style:  GoogleFonts.outfit(
                                      color: Color(0xff7C7D82),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  const SizedBox(height: 7,),
                                  TextFormField(
                                    keyboardType: TextInputType.name,
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
                                      hintText: "e.g Bryan Adam",
                                      hintStyle: const TextStyle(
                                        color: Color(0xffBCBDC0),
                                        fontSize: 16,
                                      ),
                                    ),
                                    validator: ValidationBuilder().build(),
                                    onChanged: (value) {
                                      // controller.updateEmail(value);
                                    },
                                  )
                                ],
                              ),
                              const SizedBox(height: 15,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Card Number",
                                    style:  GoogleFonts.outfit(
                                      color: Color(0xff7C7D82),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  const SizedBox(height: 7,),
                                  TextFormField(
                                    keyboardType: TextInputType.name,
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
                                      hintText: "e.g **** **** **** 3726",
                                      hintStyle: const TextStyle(
                                        color: Color(0xffBCBDC0),
                                        fontSize: 16,
                                      ),
                                    ),
                                    validator: ValidationBuilder().build(),
                                    onChanged: (value) {
                                      // controller.updateEmail(value);
                                    },
                                  )
                                ],
                              ),
                              const SizedBox(height: 15,),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Expiry Date",
                                          style:  GoogleFonts.outfit(
                                            color: Color(0xff7C7D82),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        const SizedBox(height: 7,),
                                        TextFormField(
                                          keyboardType: TextInputType.name,
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
                                            hintText: "12/06/2003",
                                            hintStyle: const TextStyle(
                                              color: Color(0xffBCBDC0),
                                              fontSize: 16,
                                            ),
                                          ),
                                          validator: ValidationBuilder().build(),
                                          onChanged: (value) {
                                            // controller.updateEmail(value);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 15,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "CVV",
                                          style:  GoogleFonts.outfit(
                                            color: Color(0xff7C7D82),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        const SizedBox(height: 7,),
                                        TextFormField(
                                          keyboardType: TextInputType.name,
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
                                            hintText: "400",
                                            hintStyle: const TextStyle(
                                              color: Color(0xffBCBDC0),
                                              fontSize: 16,
                                            ),
                                          ),
                                          validator: ValidationBuilder().build(),
                                          onChanged: (value) {
                                            // controller.updateEmail(value);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30,),
                              SizedBox(
                                height: 56,
                                width: Get.width,
                                child: ElevatedButton(
                                  onPressed: (){
                                    // (_formKey.currentState!.validate())?
                                    // controller.login() 
                                    // :
                                    // AutovalidateMode.disabled;
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
                                    "Add Payment",
                                    style:  TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: "PlusJakartaSansMed"
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],  
              ),
            ),
          )
        ],
      ),
    );
  }
}