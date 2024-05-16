import 'package:commerce/controller/home_state_controller.dart';
import 'package:commerce/routes/app/app_route_names.dart';
import 'package:commerce/widgets/bottomsheets/upload_profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class FakeEditProfileScreen extends StatelessWidget {
  FakeEditProfileScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> genders = [
    "Male",
    "Female"
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeStateController>(
      builder: (controller) {
        return Scaffold(
          body: SizedBox(
            height: Get.height,
            width: Get.width,
            child: SafeArea(
              child: Form(
                key: _formKey,
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
                                  Get.offAllNamed(holder);
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
                                  "Edit Profile",
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
                    ),
                    const SizedBox(height: 10,),
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 10,),
                              Stack(
                                children: [
                                  Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image:(controller.selectedImage != null)?
                                          FileImage(controller.selectedImage!)
                                          :
                                          (controller.userModel.image == "" || controller.userModel.image == null)?
                                          const AssetImage(
                                            "assets/images/avatar.png",
                                          ):
                                          NetworkImage(
                                            controller.userModel.image!,
                                          ) as ImageProvider,
                                          fit: BoxFit.cover,
                                      )
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            UploadProfilePicture.show(context);
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: Get.width,
                                                alignment: Alignment.center,
                                                child: SvgPicture.asset(
                                                  "assets/images/editButton.svg",
                                                ),
                                              ),
                                              Positioned(
                                                child: Container(
                                                  width: Get.width,
                                                  alignment: Alignment.center,
                                                  child: const Text(
                                                    "Edit",
                                                    style:  TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
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
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Firstname",
                                    style:  TextStyle(
                                      color: Color(0xff7C7D82),
                                      fontSize: 12,
                                      fontFamily: "PlusJakartaSansMed"
                                    ),
                                  ),
                                  const SizedBox(height: 7,),
                                  TextFormField(
                                    controller: controller.firstname,
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
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
          
                                      ),
                                      hintText: "Firstname",
                                      hintStyle: const TextStyle(
                                        color: Color(0xffBCBDC0),
                                        fontSize: 16,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 15,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Lastname",
                                    style:  TextStyle(
                                      color: Color(0xff7C7D82),
                                      fontSize: 12,
                                      fontFamily: "PlusJakartaSansMed"
                                    ),
                                  ),
                                  const SizedBox(height: 7,),
                                  TextFormField(
                                    controller: controller.lastname,
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
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
          
                                      ),

                                      hintText: "Lastname",
                                      hintStyle: const TextStyle(
                                        color: Color(0xffBCBDC0),
                                        fontSize: 16,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 15,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Date of Birth",
                                    style:  TextStyle(
                                      color: Color(0xff7C7D82),
                                      fontSize: 12,
                                      fontFamily: "PlusJakartaSansMed"
                                    ),
                                  ),
                                  const SizedBox(height: 7,),
                                  TextFormField(
                                    onTap: () {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      controller.showDataePicker(context);
                                    },
                                    controller: controller.dob,
                                    keyboardType: TextInputType.datetime,
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
                                      hintText: "DD/MM/YYYY",
                                      hintStyle: const TextStyle(
                                        color: Color(0xffBCBDC0),
                                        fontSize: 16,
                                      ),
                                      suffixIcon: InkWell(
                                        onTap: (){
                                          controller.showDataePicker(context);
                                        },
                                        child: const Icon(
                                          Iconsax.calendar_1,
                                          color: Color(0xff053969),
                                        ),
                                      )
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 15,),
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
                                    enabled: false,
                                    controller: controller.email,
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
                                      disabledBorder: OutlineInputBorder(
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
                                  )
                                ],
                              ),
                              const SizedBox(height: 15,),
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
                                    controller: controller.phone,
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
                              const SizedBox(height: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Gender",
                                    style:  TextStyle(
                                      color: Color(0xff7C7D82),
                                      fontSize: 12,
                                      fontFamily: "PlusJakartaSansMed"
                                    ),
                                  ),
                                  const SizedBox(height: 7,),
                                  DropdownButtonFormField(
                                    value: (controller.gender.text.isEmpty)?
                                    null:
                                    controller.gender.text,
                                    items: List.generate(genders.length, (index) => DropdownMenuItem(
                                      value: genders[index],
                                      child: Text(
                                        genders[index]
                                      ),
                                      onTap: () {
                                        controller.updateGender(genders[index]);
                                      },
                                    )),
                                    onChanged: (value) {
                                      // controller.updateGender(value);
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
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Color(0xffEAEAEA)
                                        )
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      hintText: "Select gender",
                                      hintStyle: const TextStyle(
                                        color: Color(0xffBCBDC0),
                                        fontSize: 16,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20,),
                            ],
                          ),
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
                                controller.updateProfile(context) 
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
                        ),
                      ),
                    ),
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