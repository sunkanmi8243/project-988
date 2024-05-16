import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../controller/auth_state_controller.dart';
import '../../routes/app/app_route_names.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({super.key});

  final AuthStateController _authStateController = Get.put(AuthStateController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20,),
                      const Text(
                        "Create your new\naccount",
                        style:  TextStyle(
                          color: Color(0xff292A2E),
                          fontSize: 32,
                          fontFamily: "PlusJakartaSansBold"
                        ),
                      ),
                      const SizedBox(height: 30,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Email Address",
                            style:  TextStyle(
                              color: Color(0xff7C7D82),
                              fontSize: 12,
                              fontFamily: "PlusJakartaSansMed"
                            ),
                          ),
                          const SizedBox(height: 7,),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
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
                              hintText: "Email address",
                              hintStyle: const TextStyle(
                                color: Color(0xffBCBDC0),
                                fontSize: 16,
                              ),
                            ),
                            validator: ValidationBuilder().email().build(),
                            onChanged: (value) {
                              controller.updateEmail(value);
                            },
                          )
                        ],
                      ),
                      
                      const SizedBox(height: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Password",
                            style:  TextStyle(
                              color: Color(0xff7C7D82),
                              fontSize: 12,
                              fontFamily: "PlusJakartaSansMed"
                            ),
                          ),
                          const SizedBox(height: 7,),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
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
                              hintText: "Password",
                              hintStyle: const TextStyle(
                                color: Color(0xffBCBDC0),
                                fontSize: 16,
                              ),
                              suffixIcon: InkWell(
                                onTap: () {
                                  controller.updateHidePassword();
                                },
                                child: (controller.hidePassword)?
                                const Icon(
                                  Iconsax.eye_slash,
                                  color: Color(0xff053969),
                                ):
                                const Icon(
                                  Iconsax.eye,
                                  color: Color(0xff053969),
                                ),
                              )
                            ),
                            obscureText: !controller.hidePassword,
                            validator: ValidationBuilder().build(),
                            onChanged: (value) {
                              controller.updatePassword(value);
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Confirm Password",
                            style:  TextStyle(
                              color: Color(0xff7C7D82),
                              fontSize: 12,
                              fontFamily: "PlusJakartaSansMed"
                            ),
                          ),
                          const SizedBox(height: 7,),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
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
                              hintText: "Password",
                              hintStyle: const TextStyle(
                                color: Color(0xffBCBDC0),
                                fontSize: 16,
                              ),
                              suffixIcon: InkWell(
                                onTap: () {
                                  controller.updateHidePassword();
                                },
                                child: (controller.hidePassword)?
                                const Icon(
                                  Iconsax.eye_slash,
                                  color: Color(0xff053969),
                                ):
                                const Icon(
                                  Iconsax.eye,
                                  color: Color(0xff053969),
                                ),
                              )
                            ),
                            obscureText: !controller.hidePassword,
                            validator: ValidationBuilder().build(),
                            onChanged: (value) {
                              controller.updatePasswordConfirm(value);
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 25,),
                      SizedBox(
                        height: 56,
                        width: Get.width,
                        child: ElevatedButton(
                          onPressed: (){
                            (_formKey.currentState!.validate())?
                            controller.register()
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
                            "Register",
                            style:  TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: "PlusJakartaSansMed"
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25,),
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Color(0xffEAEAEA),
                              thickness: 1.2,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text(
                            "or continue with",
                            style:  TextStyle(
                              color: Color(0xff7C7D82),
                              fontSize: 16,
                              fontFamily: "PlusJakartaSansMed"
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Divider(
                              color: Color(0xffEAEAEA),
                              thickness: 1.2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25,),
                      SizedBox(
                        height: 56,
                        width: Get.width,
                        child: ElevatedButton(
                          onPressed: (){}, 
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            side: const BorderSide(
                              color: Color(0xffEAEAEA)
                            ),
                            backgroundColor: Colors.transparent
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/images/google.svg"
                              ),
                              const SizedBox(width: 10,),
                              const Text(
                                "Continue with google",
                                style:  TextStyle(
                                  color: Color(0xff292A2E),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      SizedBox(
                        height: 56,
                        width: Get.width,
                        child: ElevatedButton(
                          onPressed: (){}, 
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            side: const BorderSide(
                              color: Color(0xffEAEAEA)
                            ),
                            backgroundColor: Colors.transparent
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/images/facebook.svg"
                              ),
                              const SizedBox(width: 10,),
                              const Text(
                                "Continue with facebook",
                                style:  TextStyle(
                                  color: Color(0xff292A2E),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 25,),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: (){
                            Get.toNamed(loginScreen);
                          },
                          child: RichText(
                            text: const TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(
                                color: Color(0xff7C7D82),
                                fontSize: 16,
                                fontFamily: "PlusJakartaSans"
                              ),
                              children: [
                                TextSpan(
                                  text: " Login",
                                  style: TextStyle(
                                    color: Color(0xff1B5EC9),
                                    fontSize: 16,
                                    fontFamily: "PlusJakartaSansBold"
                                  ),
                                )
                              ]
                            )
                          ),
                        ),
                      )
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