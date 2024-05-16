import 'dart:async';

import 'package:commerce/controller/auth_state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final email = Get.arguments["email"];
  final AuthStateController _authStateController = Get.find<AuthStateController>();
  late Timer _timer;
  int _counter = 60;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          // Trigger your resend email function here
          _authStateController.resendVerifyEmail();
          // Reset the counter to 60 seconds
          _counter = 60;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<AuthStateController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            height: Get.height,
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20,),
                      Stack(
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
                                  "OTP",
                                  style:  TextStyle(
                                    color: Color(0xff292A2E),
                                    fontSize: 18,
                                    fontFamily: "PlusJakartaSansMed"
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30,),
                      SvgPicture.asset(
                        "assets/images/OTP.svg"
                      ),
                      const SizedBox(height: 20,),
                      const Text(
                        "Verification code",
                        style:  TextStyle(
                          color: Color(0xff292A2E),
                          fontSize: 24,
                          fontFamily: "PlusJakartaSansMed"
                        ),
                      ),
                      const SizedBox(height: 20,),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "We have sent the code verification to your email ",
                          style:  const TextStyle(
                            color: Color(0xff7C7D82),
                            fontSize: 14,
                            fontFamily: "PlusJakartaSans"
                          ),
                          children: [
                            TextSpan(
                              text: " $email",
                              style:  const TextStyle(
                                color: Color(0xff292A2E),
                                fontSize: 14,
                                fontFamily: "PlusJakartaSansBold"
                              ),
                            )
                          ]
                        )
                      ),
                      const SizedBox(height: 20,),
                      PinCodeTextField(
                        appContext: context,
                        length: 6,
                        autoFocus: true,
                        obscureText: false,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(12),
                          fieldHeight: 72,
                          fieldWidth: 75,
                          activeColor: const Color(0xffEAEAEA),
                          selectedColor: const Color(0xffEAEAEA),
                          inactiveColor: const Color(0xffEAEAEA),
                        ),
                        validator: ValidationBuilder().build(),
                        onChanged: (value) {
                          controller.updateOtp(value);
                        },
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        "Resend code in $_counter s",
                        style:  const TextStyle(
                          color: Color(0xff292A2E),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 50,),
                      SizedBox(
                        height: 56,
                        width: Get.width,
                        child: ElevatedButton(
                          onPressed: (){
                            (_formKey.currentState!.validate())?
                            controller.verifyPasswordEmail()
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
                            "Continue",
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
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}