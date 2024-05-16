import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerce/controller/home_state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:translator/translator.dart';

import '../../../../routes/app/app_route_names.dart';
import '../../../../storage/secureStorage.dart';

class CartView extends StatefulWidget {
  CartView({super.key});

  final HomeStateController _homeStateController = Get.find<HomeStateController>();
  // final AppStateController _appStateController = Get.put(AppStateController());

    @override
  State<CartView> createState() => _CartViewState();
}

enum TtsState { playing, stopped }

class _CartViewState extends State<CartView> {

  var number = NumberFormat("#,###");
  Future<String> translate(String text) async{
    String language = await LocalStorage().fetchLanguage();
    Translation translatedText = await text.translate(to: language == ""? "en" : language);
    log(translatedText.toString());
    return translatedText.toString();
  }

  @override
  void dispose() {
    super.dispose();
    widget._homeStateController.clearItemQuantities();
    widget._homeStateController.updateItemList();
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget._homeStateController.getCarts2();
    });


    return GetBuilder<HomeStateController>(
      builder: (controller) {
        return LoadingOverlay(
          isLoading: controller.isCartLoading,
          progressIndicator: const SpinKitFadingCircle(
            color: Color(0xff265682),
            size: 50,
          ),
          child: Scaffold(
            body: SizedBox(
              height: Get.height,
              width: Get.width,
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                      const Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 20),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                             Positioned(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Cart",
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
                      Expanded(
                        flex: 9,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 20,),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: (controller.carts.isEmpty)?
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/emptycart.svg"
                                    ),
                                    const SizedBox(height: 20,),
                                    FutureBuilder(
                                      future: translate("Your cart is an empty!"),
                                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return const Text(
                                            "Loading...",
                                            style:  TextStyle(
                                              color: Color(0xff292A2E),
                                              fontSize: 20,
                                              fontFamily: "PlusJakartaSansMed"
                                            ),
                                          ); // or any loading indicator
                                        } else {
                                          return Text(
                                            snapshot.data ?? "",
                                            style:  const TextStyle(
                                              color: Color(0xff292A2E),
                                              fontSize: 20,
                                              fontFamily: "PlusJakartaSansMed"
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 10,),
                                    FutureBuilder(
                                      future: translate("Looks like you haven't added anything to your cart yet"),
                                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return const Text(
                                            "Loading...",
                                            style:  TextStyle(
                                              color: Color(0xff7C7D82),
                                              fontSize: 14,
                                            ),
                                          ); // or any loading indicator
                                        } else {
                                          return Text(
                                            snapshot.data ?? "",
                                            style:  const TextStyle(
                                              color: Color(0xff7C7D82),
                                              fontSize: 14,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 30,),
                                    SizedBox(
                                      height: 56,
                                      width: Get.width,
                                      child: ElevatedButton(
                                        onPressed: (){
                                          Get.toNamed(holder);
                                        }, 
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          backgroundColor: const Color(0xff053969)
                                        ),
                                        child: FutureBuilder(
                                          future: translate("Start Shopping"),
                                          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return const Text(
                                                "Loading...",
                                                style:  TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontFamily: "PlusJakartaSansMed"
                                                ),
                                              ); // or any loading indicator
                                            } else {
                                              return Text(
                                                snapshot.data ?? "",
                                                style:  const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontFamily: "PlusJakartaSansMed"
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20,),
                                  ],
                                )
                                :
                                (controller.isItemLoading)?
                                SizedBox(
                                  height: 200,
                                  width: Get.width,
                                  child: const Center(
                                    child:  SpinKitFadingCircle(
                                      color: Color(0xff265682),
                                      size: 50,
                                    ),
                                  ),
                                ):
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: ListView.separated(
                                    primary: false,
                                    shrinkWrap: true,
                                    itemCount: controller.carts.length,
                                    separatorBuilder: (context, index) {
                                      return const Divider(
                                        color: Color(0xffEAEAEA),
                                      );
                                    },
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Row(
                                          children: [
                                            Checkbox.adaptive(
                                              value: controller.isCheckedList.isEmpty ? false : controller.isCheckedList[index], 
                                              onChanged: (value){
                                                controller.toggleCartItemCheck(index, controller.carts[index]);
                                              },
                                              activeColor: const Color(0xffFF9C44),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(4)
                                              ),
                                              side: const BorderSide(
                                                color: Color(0xffEAEAEA)
                                              ),
                                            ),
                                            const SizedBox(width: 10,),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 108,
                                                    width: 108,
                                                    padding: const EdgeInsets.all(15),
                                                    decoration: BoxDecoration(
                                                      color: const Color(0xffF3F6FB),
                                                      borderRadius: BorderRadius.circular(12)
                                                    ),
                                                    child: CachedNetworkImage(
                                                      imageUrl: controller.carts[index]["image"],
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
                                                  ),
                                                  const SizedBox(width: 15,),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        FutureBuilder(
                                                          future: translate(controller.carts[index]["name"]),
                                                          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                                              return const Text(
                                                                "Loading...",
                                                                style: TextStyle(
                                                                  color: Color(0xff292A2E),
                                                                  fontSize: 14,
                                                                  fontFamily: "PlusJakartaSansBold"
                                                                ),
                                                              ); // or any loading indicator
                                                            } else {
                                                              return Text(
                                                                snapshot.data ?? "",
                                                                style: const TextStyle(
                                                                  color: Color(0xff292A2E),
                                                                  fontSize: 14,
                                                                  fontFamily: "PlusJakartaSansBold"
                                                                ),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                        const SizedBox(height: 5,),
                                                        RichText(
                                                          text: TextSpan(
                                                            text: "\$ ${number.format(int.parse(controller.carts[index]["price"].toString().split(".").first))}",
                                                            style: const TextStyle(
                                                              color: Color(0xff053969),
                                                              fontSize: 14,
                                                              fontFamily: "PlusJakartaSansBold"
                                                            ),
                                                            // children: [
                                                            //   TextSpan(
                                                            //     text: " \$ ${controller.carts[index]["slashed"]}",
                                                            //     style: const TextStyle(
                                                            //       color: Color(0xff7C7D82),
                                                            //       fontSize: 10,
                                                            //       fontFamily: "PlusJakartaSans",
                                                            //       decoration: TextDecoration.lineThrough
                                                            //     ),
                                                            //   )
                                                            // ]
                                                          ),
                                                        ),
                                                        const SizedBox(height: 10,),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    (controller.itemQuantities[index] == 0)?
                                                                    null:
                                                                    controller.decrementItem(
                                                                      controller.carts[index]["id"], 
                                                                      index,
                                                                    );
                                                                  },
                                                                  child: SvgPicture.asset(
                                                                    "assets/images/Min.svg"
                                                                  ),
                                                                ),
                                                                const SizedBox(width: 10,),
                                                                (controller.isLoading)?
                                                                const Center(
                                                                  child: SpinKitFadingCircle(
                                                                    color: Color(0xff265682),
                                                                    size: 10,
                                                                  ),
                                                                ):
                                                                Text(
                                                                  controller.itemQuantities[index].toString(),
                                                                  style: const TextStyle(
                                                                    color: Color(0xff303336),
                                                                    fontSize: 14,
                                                                    fontFamily: "PlusJakartaSansMed"
                                                                  ),
                                                                ),
                                                                const SizedBox(width: 10,),
                                                                InkWell(
                                                                  onTap: () {
                                                                    controller.addItem(
                                                                      controller.carts[index]["id"], 
                                                                      index,
                                                                    );
                                                                  },
                                                                  child: SvgPicture.asset(
                                                                    "assets/images/Plus.svg"
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                controller.deleteFromCart(controller.carts[index]["id"] ,controller.carts[index], controller.carts[index]["key"]);
                                                              },
                                                              child: SvgPicture.asset(
                                                                "assets/images/trash.svg"
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              
                              ),
                              const Divider(
                                color: Color(0xffF0F1F5),
                                thickness: 4,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          FutureBuilder(
                                            future: translate("Sum Total:"),
                                            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                return const Text(
                                                  "Loading...",
                                                  style: TextStyle(
                                                    color: Color(0xff292A2E),
                                                    fontSize: 16,
                                                    fontFamily: "PlusJakartaSansBold"
                                                  ),
                                                ); // or any loading indicator
                                              } else {
                                                return Text(
                                                  snapshot.data ?? "",
                                                  style: const TextStyle(
                                                    color: Color(0xff292A2E),
                                                    fontSize: 16,
                                                    fontFamily: "PlusJakartaSansBold"
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              text: "\$ ${controller.totalSumOfCart}",
                                              style: const TextStyle(
                                                color: Color(0xff053969),
                                                fontSize: 14,
                                                fontFamily: "PlusJakartaSansBold"
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20,),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      (controller.carts.isEmpty)?
                      const SizedBox()
                      :
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                            child: SizedBox(
                              height: 56,
                              width: Get.width,
                              child: ElevatedButton(
                                onPressed: (){
                                  Get.toNamed(
                                    addressOrderScreen,
                                    arguments: {
                                      'key': controller.checkedItemList[0]["key"],
                                      "details": controller.checkedItemList[0],
                                    }
                                  );
                                }, 
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  backgroundColor: const Color(0xff053969)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                   FutureBuilder(
                                      future: translate("Checkout"),
                                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return const Text(
                                            "Loading...",
                                            style:  TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontFamily: "PlusJakartaSansMed"
                                            ),
                                          ); // or any loading indicator
                                        } else {
                                          return Text(
                                            snapshot.data ?? "",
                                            style:  const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontFamily: "PlusJakartaSansMed"
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    const SizedBox(width: 10,),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle
                                      ),
                                      child: Text(
                                        controller.checkedItemList.length.toString(),
                                        style:  const TextStyle(
                                          color: Color(0xff292A2E),
                                          fontSize: 12,
                                          fontFamily: "PlusJakartaSansMed"
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}