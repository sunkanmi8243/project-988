
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerce/controller/home_state_controller.dart';
import 'package:commerce/routes/app/app_route_names.dart';
import 'package:commerce/widgets/bottomsheets/logout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:translator/translator.dart';

import '../../../../storage/secureStorage.dart';
import '../../../../widgets/bottomsheets/leaveReview.dart';

class ProfileView extends StatefulWidget {
  ProfileView({super.key});

  final HomeStateController _homeStateController = Get.find<HomeStateController>();

    @override
  State<ProfileView> createState() => _ProfileViewState();
}

enum TtsState { playing, stopped }

class _ProfileViewState extends State<ProfileView> {

  late FlutterTts _flutterTts;

  Future<String> translate(String text) async{
    String language = await LocalStorage().fetchLanguage();
    Translation translatedText = await text.translate(to: language == ""? "en" : language);
    log(translatedText.toString());
    return translatedText.toString();
  }

  Future speak() async {

    String code = await LocalStorage().fetchLanguage();

    widget._homeStateController.triggerVoice(
      code == "id"?
      "id-ID": 
      code == "en"?
      "en-US": 
      code == "th"?
      "ja-JP": 
      code == "zh-cn"?
      "yue-CN": 
      "en-US",
      "Your profile name is, ${widget._homeStateController.userModel.firstname} ${widget._homeStateController.userModel.lastname}, there are different settings here including Address, Payment methods, Notifications, Account security. You can also invite friends, check out our privacy policy and help center. If you wish you can log out too.");
    }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<HomeStateController>(
      builder: (controller) {
        return Scaffold(
          body: LoadingOverlay(
            isLoading: controller.isItemLoading || controller.isVoiceLoading,
            progressIndicator: const SpinKitFadingCircle(
              color: Color(0xff053969),
              size: 50,
            ),
            child: SizedBox(
              height: Get.height,
              width: Get.width,
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/Vector 15.png"
                  ),
                  Positioned(
                    right: 0,
                    child: Image.asset(
                      "assets/images/Vector 16.png"
                    ),
                  ),
                  SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const Positioned(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Profile",
                                      style:  TextStyle(
                                        color: Color(0xff292A2E),
                                        fontSize: 18,
                                        fontFamily: "PlusJakartaSansMed"
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
                                      controller.getSpeech("Your profile name is, ${widget._homeStateController.userModel.firstname} ${widget._homeStateController.userModel.lastname}, there are different settings here including Address, Payment methods, Notifications, Account security. You can also invite friends, check out our privacy policy and help center. If you wish you can log out too.");
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
                        const SizedBox(height: 15),
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 45,
                              backgroundImage: (controller.selectedImage != null)?
                              FileImage(controller.selectedImage!)
                              :
                              (controller.userModel.image == "" || controller.userModel.image == null)?
                              const AssetImage(
                                "assets/images/avatar.png",
                              ):
                              NetworkImage(
                                controller.userModel.image!,
                              ) as ImageProvider,
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(editProfileScreen);
                                },
                                child: Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: Border.all(
                                      color: const Color(0xff053969)
                                    )
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    size: 20,
                                    color: Color(0xff053969)
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 15,),
                        Text(
                          "${controller.firstname.text} ${controller.lastname.text}",
                          style:  const TextStyle(
                            color: Color(0xff292A2E),
                            fontSize: 18,
                            fontFamily: "PlusJakartaSansMed"
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          controller.email.text,
                          style:  const TextStyle(
                            color: Color(0xff7C7D82),
                            fontSize: 14,
                            // fontFamily: "PlusJakartaSansMed"
                          ),
                        ),
                        const SizedBox(height: 30),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(top: 20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              )
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(height: 5,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            FutureBuilder(
                                              future: translate("My Orders"),
                                              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                  return const Text(
                                                    "Loading...",
                                                    style:  TextStyle(
                                                      color: Color(0xff292A2E),
                                                      fontSize: 18,
                                                      fontFamily: "PlusJakartaSansMed"
                                                    ),
                                                  ); // or any loading indicator
                                                } else {
                                                  return Text(
                                                    snapshot.data ?? "",
                                                    style: const TextStyle(
                                                      color: Color(0xff292A2E),
                                                      fontSize: 18,
                                                      fontFamily: "PlusJakartaSansMed"
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.toNamed(orderScreen);
                                              },
                                              child: FutureBuilder(
                                                future: translate("View orders"),
                                                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                                    return const Text(
                                                      "",
                                                      style:  TextStyle(
                                                        color: Color(0xff1B5EC9),
                                                        fontSize: 14,
                                                        fontFamily: "PlusJakartaSansMed"
                                                      ),
                                                    ); // or any loading indicator
                                                  } else {
                                                    return Text(
                                                      snapshot.data ?? "",
                                                      style:  const TextStyle(
                                                        color: Color(0xff1B5EC9),
                                                        fontSize: 14,
                                                        fontFamily: "PlusJakartaSansMed"
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 30),
                                        (controller.isLoading)?
                                        const SpinKitFadingCircle(
                                          color: Color(0xff265682),
                                          size: 30,
                                        ):
                                        (controller.orders.isEmpty)?
                                        FutureBuilder(
                                          future: translate("No active orders"),
                                          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return const Text(
                                                "",
                                                style:  TextStyle(
                                                  color: Color(0xff292A2E),
                                                  fontSize: 14,
                                                  fontFamily: "PlusJakartaSansMed"
                                                ),
                                              ); // or any loading indicator
                                            } else {
                                              return Text(
                                                snapshot.data ?? "",
                                                style:  const TextStyle(
                                                  color: Color(0xff292A2E),
                                                  fontSize: 14,
                                                  fontFamily: "PlusJakartaSansMed"
                                                ),
                                              );
                                            }
                                          },
                                        ):
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(16),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(0, 20),
                                                blurRadius: 32,
                                                spreadRadius: -8,
                                                color: const Color(0xff576F85).withOpacity(0.2)
                                              )
                                            ]
                                          ),
                                          child: Column(children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                RichText(
                                                  text: const TextSpan(
                                                    text: "Order ID ",
                                                    style: TextStyle(
                                                      color: Color(0xff7C7D82),
                                                      fontSize: 12,
                                                      fontFamily: "PlusJakartaSansMed"
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: " 4466379911",
                                                        style: TextStyle(
                                                          color: Color(0xff292A2E),
                                                          fontSize: 12,
                                                          fontFamily: "PlusJakartaSansMed"
                                                        ),
                                                      )
                                                    ]
                                                  )
                                                ),
                                                (controller.pendingOrders.isNotEmpty)?
                                                FutureBuilder(
                                                  future: translate("Pending"),
                                                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                                      return const Text(
                                                        "",
                                                        style:  TextStyle(
                                                          color: Color(0xffFF9C44),
                                                          fontSize: 12,
                                                          fontFamily: "PlusJakartaSansMed"
                                                        ),
                                                      ); // or any loading indicator
                                                    } else {
                                                      return Text(
                                                        snapshot.data ?? "",
                                                        style:  const TextStyle(
                                                          color: Color(0xffFF9C44),
                                                          fontSize: 12,
                                                          fontFamily: "PlusJakartaSansMed"
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ):
                                                (controller.ongoingOrders.isNotEmpty)?
                                                SvgPicture.asset(
                                                  "assets/images/Badge.svg"
                                                ):
                                                SvgPicture.asset(
                                                  "assets/images/completedButton.svg"
                                                ),
                                              ]
                                            ),
                                            const SizedBox(height: 5),
                                            const Divider(
                                              color: Color(0xffEAEAEA),
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      CachedNetworkImage(
                                                        imageUrl: (controller.pendingOrders.isNotEmpty)?
                                                        controller.pendingOrders[0]["order_items"][0]["product"]["image"]:
                                                        (controller.ongoingOrders.isNotEmpty)?
                                                        controller.ongoingOrders[0]["order_items"][0]["product"]["image"]:
                                                        (controller.completedOrders.isNotEmpty)?
                                                        controller.completedOrders[0]["order_items"][0]["product"]["image"]:
                                                        "",
                                                        height: 50,
                                                        width: 50,
                                                        progressIndicatorBuilder: (context, url, downloadProgress) => const Center(
                                                          child: Center(
                                                            child: SpinKitFadingCircle(
                                                              color: Color(0xff265682),
                                                              size: 30,
                                                            ),
                                                          )
                                                        ),
                                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Expanded(
                                                        child: Text(
                                                          (controller.pendingOrders.isNotEmpty)?
                                                          controller.pendingOrders[0]["order_items"][0]["product"]["name"]:
                                                          (controller.ongoingOrders.isNotEmpty)?
                                                          controller.ongoingOrders[0]["order_items"][0]["product"]["name"]:
                                                          (controller.completedOrders.isNotEmpty)?
                                                          controller.completedOrders[0]["order_items"][0]["product"]["name"]:
                                                          "",
                                                          style:  const TextStyle(
                                                            color: Color(0xff292A2E),
                                                            fontSize: 14,
                                                            fontFamily: "PlusJakartaSansBold"
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                (controller.pendingOrders.isNotEmpty)?
                                                SizedBox(
                                                  height: 32,
                                                  // width: 90,
                                                  child: ElevatedButton(
                                                    onPressed: (){
                                                      controller.payForOrder(controller.pendingOrders[0]["id"]);
                                                    }, 
                                                    style: ElevatedButton.styleFrom(
                                                      elevation: 0,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(50),
                                                      ),
                                                      backgroundColor: const Color(0xff053969)
                                                    ),
                                                    child:FutureBuilder(
                                                    future: translate("Buy Now"),
                                                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                                        return const Text(
                                                          "Loading...",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 11,
                                                            fontFamily: "PlusJakartaSansMed"
                                                          ),
                                                        ); // or any loading indicator
                                                      } else {
                                                        return Text(
                                                          snapshot.data ?? "",
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 11,
                                                            fontFamily: "PlusJakartaSansMed"
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                  ),
                                                ):
                                                (controller.ongoingOrders.isNotEmpty)?
                                                SvgPicture.asset(
                                                  "assets/images/trackButton.svg"
                                                ):
                                                (controller.completedOrders.isNotEmpty)?
                                                InkWell(
                                                  onTap: () {
                                                    LeaveReview.showLeaveReview();
                                                  },
                                                  child: SvgPicture.asset(
                                                    "assets/images/review.svg",
                                                  ),
                                                ):
                                                SvgPicture.asset(
                                                  "assets/images/trackButton.svg"
                                                ),
                                              ],
                                            )
                                          ],),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Divider(
                                    thickness: 4,
                                    color: Color(0xffF0F1F5),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10),
                                        const Text(
                                          "Account Settings",
                                          style:  TextStyle(
                                            color: Color(0xff7C7D82),
                                            fontSize: 14,
                                            // fontFamily: "PlusJakartaSansMed"
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        _listTile("assets/images/Icon.svg", "Address", (){
                                          Get.toNamed(addressScreen);
                                        }),
                                        const Divider(
                                          color: Color(0xffF0F1F5),
                                        ),
                                        _listTile("assets/images/Icon-1.svg", "Payment Method", (){
                                          Get.toNamed(paymentMethodScreen);
                                        }),
                                        const Divider(
                                          color: Color(0xffF0F1F5),
                                        ),
                                        ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          leading: SvgPicture.asset("assets/images/Icon-2.svg"),
                                          title: const Text(
                                            "Notification",
                                            style:  TextStyle(
                                              color: Color(0xff292A2E),
                                              fontSize: 16,
                                              fontFamily: "PlusJakartaSansMed"
                                            ),
                                          ),
                                          trailing: CupertinoSwitch(value: controller.notification, onChanged: (value){
                                            controller.toggleNotification();
                                          })
                                        ),
                                        const Divider(
                                          color: Color(0xffF0F1F5),
                                        ),
                                        _listTile("assets/images/Icon-3.svg", "Account Security", (){}),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Divider(
                                    thickness: 4,
                                    color: Color(0xffF0F1F5),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10),
                                        const Text(
                                          "General",
                                          style:  TextStyle(
                                            color: Color(0xff7C7D82),
                                            fontSize: 14,
                                            // fontFamily: "PlusJakartaSansMed"
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        _listTile("assets/images/Icon3.svg", "Invite Friends", (){}),
                                        const Divider(
                                          color: Color(0xffF0F1F5),
                                        ),
                                        _listTile("assets/images/Icon1.svg", "Privacy Policy", (){
                                          Get.toNamed(privacyPolicyScreen);
                                        }),
                                        const Divider(
                                          color: Color(0xffF0F1F5),
                                        ),
                                        _listTile("assets/images/Icon2.svg", "Help Center", (){}),
                                        
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Divider(
                                    thickness: 4,
                                    color: Color(0xffF0F1F5),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: ListTile(
                                      onTap: () {
                                        LogoutBottomSheet.show(context);
                                      },
                                      contentPadding: EdgeInsets.zero,
                                      leading: SvgPicture.asset("assets/images/logout.svg"),
                                      title: const Text(
                                        "Logout",
                                        style:  TextStyle(
                                          color: Color(0xffFF5944),
                                          fontSize: 16,
                                          fontFamily: "PlusJakartaSansMed"
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
  ListTile _listTile(image, title, Function() onTap){
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset(image),
      title: Text(
        title,
         style: const TextStyle(
          color: Color(0xff292A2E),
          fontSize: 16,
          fontFamily: "PlusJakartaSansMed"
        ),
      ),
      trailing: const Icon(
        Iconsax.arrow_right_3,
        size: 20,
        color: Color(0xff053969),
      ),
    );
  }
}