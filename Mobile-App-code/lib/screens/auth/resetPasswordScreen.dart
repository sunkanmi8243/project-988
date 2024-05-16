import 'package:commerce/controller/auth_state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

    final AuthStateController _authStateController = Get.find<AuthStateController>();
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
                        "Login to your\naccount.",
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
                            "New Password",
                            style:  TextStyle(
                              color: Color(0xff7C7D82),
                              fontSize: 12,
                              fontFamily: "PlusJakartaSansMed"
                            ),
                          ),
                          const SizedBox(height: 7,),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
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
                            "Confirm password",
                            style:  TextStyle(
                              color: Color(0xff7C7D82),
                              fontSize: 12,
                              fontFamily: "PlusJakartaSansMed"
                            ),
                          ),
                          const SizedBox(height: 7,),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
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
                              hintText: "Confirm password",
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
                            controller.resetPassword() 
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
                            "Reset",
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