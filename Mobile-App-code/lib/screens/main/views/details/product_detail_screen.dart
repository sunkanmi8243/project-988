import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerce/controller/home_state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:readmore/readmore.dart';
import 'package:translator/translator.dart';

import '../../../../routes/app/app_route_names.dart';
import '../../../../storage/secureStorage.dart';

class ProductDetailScreen extends StatefulWidget {
   ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

enum TtsState { playing, stopped }

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  final HomeStateController _homeStateController = Get.find<HomeStateController>();

  late FlutterTts _flutterTts;
  String? _tts;
  TtsState _ttsState = TtsState.stopped;

  final details = Get.arguments["details"];
  var number = NumberFormat("#,###");

  @override
  void initState() {
    super.initState();
  }

  Future<String> translate(String text) async{
    String language = await LocalStorage().fetchLanguage();
    Translation translatedText = await text.translate(to: language == ""? "en" : language);
    log(translatedText.toString());
    return translatedText.toString();
  }


  Future speak() async {

    String code = await LocalStorage().fetchLanguage();

    _homeStateController.triggerVoice(
      code == "id"?
      "id-ID": 
      code == "en"?
      "en-US": 
      code == "th"?
      "ja-JP": 
      code == "zh-cn"?
      "yue-CN": 
      "en-US",
      "The name of this product is ${details["name"]} ${details["description"]} and it has a fixed price of ${details["price"]} dollars");

  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<HomeStateController>(
      builder: (controller) {
        return LoadingOverlay(
          isLoading: controller.isCartLoading || controller.isVoiceLoading,
          progressIndicator: const SpinKitFadingCircle(
            color: Color(0xff265682),
            size: 50,
          ),
          child: Scaffold(
            body: SizedBox(
              height: Get.height,
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 9,
                    child: SingleChildScrollView(
                      child: SafeArea(
                        child: Stack(
                          children: [
                            Image.asset(
                              "assets/images/Ellipse 192.png"
                            ),
                            Positioned(
                              right: 0,
                              child: Image.asset(
                                "assets/images/Ellipse 193.png"
                              ),
                            ),
                            Column(
                              children: [
                                const SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          Get.back();
                                        },
                                        child: SvgPicture.asset(
                                          "assets/images/back.svg"
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.getSpeech("The name of this product is ${details["name"]} ${details["description"]} and it has a fixed price of ${details["price"]} dollars");
                                        },
                                        child: SvgPicture.asset(
                                          "assets/images/right.svg"
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 80),
                                  child: FutureBuilder(
                                    future: translate(details["name"]),
                                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Text(
                                          "Loading...",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xff292A2E),
                                            fontSize: 24,
                                            fontFamily: "PlusJakartaSansMed"
                                          ),
                                        ); // or any loading indicator
                                      } else {
                                        return Text(
                                          snapshot.data ?? "",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Color(0xff292A2E),
                                            fontSize: 24,
                                            fontFamily: "PlusJakartaSansMed"
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                RichText(
                                  text: TextSpan(
                                    text: "\$ ${number.format(int.parse(details["price"].toString().split(".").first))}",
                                    style: const TextStyle(
                                      color: Color(0xff1B5EC9),
                                      fontSize: 20,
                                      fontFamily: "PlusJakartaSansBold"
                                    ),
                                    // children: const [
                                    //   TextSpan(
                                    //     text: " \$ 1699",
                                    //     style: TextStyle(
                                    //       color: Color(0xff7C7D82),
                                    //       fontSize: 12,
                                    //       fontFamily: "PlusJakartaSans",
                                    //       decoration: TextDecoration.lineThrough
                                    //     ),
                                    //   )
                                    // ]
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: CachedNetworkImage(
                                    imageUrl: details["image"],
                                    height: 300,
                                    width: 300,
                                    progressIndicatorBuilder: (context, url, downloadProgress) => const Center(
                                      child: Center(
                                        child: SpinKitFadingCircle(
                                          color: Color(0xff265682),
                                          size: 50,
                                        ),
                                      )
                                    ),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                const Divider(
                                  thickness: 4,
                                  color: Color(0xffF0F1F5),
                                ),
                                const SizedBox(height: 15,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child:  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      FutureBuilder(
                                        future: translate("Product Description"),
                                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return const Text(
                                              "Loading...",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xff292A2E),
                                                fontSize: 24,
                                                fontFamily: "PlusJakartaSansMed"
                                              ),
                                            );
                                          } else {
                                            return Text(
                                              snapshot.data ?? "",
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Color(0xff292A2E),
                                                fontSize: 18,
                                                fontFamily: "PlusJakartaSansMed"
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                      const SizedBox(height: 7,),
                                      FutureBuilder(
                                        future: translate(details["description"]),
                                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return const ReadMoreText(
                                              "Loading...",
                                              trimLines: 3,
                                              colorClickableText:  Color(0xff1B5EC9),
                                              trimMode: TrimMode.Line,
                                              trimCollapsedText: 'Show more',
                                              trimExpandedText: 'Show less',
                                              style: TextStyle(
                                                color: Color(0xff7C7D82)
                                              ),
                                              moreStyle: TextStyle(fontSize: 14, fontFamily: "PlusJakartaSansBold", color: Color(0xff1B5EC9)),
                                            );
                                          } else {
                                            return ReadMoreText(
                                              snapshot.data ?? "",
                                              trimLines: 3,
                                              colorClickableText: const Color(0xff1B5EC9),
                                              trimMode: TrimMode.Line,
                                              trimCollapsedText: 'Show more',
                                              trimExpandedText: 'Show less',
                                              style: const TextStyle(
                                                color: Color(0xff7C7D82)
                                              ),
                                              moreStyle: const TextStyle(fontSize: 14, fontFamily: "PlusJakartaSansBold", color: Color(0xff1B5EC9)),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15,),
                                const Divider(
                                  thickness: 4,
                                  color: Color(0xffF0F1F5),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10,),
                                        FutureBuilder(
                                          future: translate("Product Related"),
                                          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return const Text(
                                                "Loading...",
                                                style: TextStyle(
                                                  color: Color(0xff292A2E),
                                                  fontSize: 18,
                                                  fontFamily: "PlusJakartaSansBold"
                                                ),
                                              );
                                            } else {
                                              return Text(
                                                snapshot.data ?? "",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Color(0xff292A2E),
                                                  fontSize: 18,
                                                  fontFamily: "PlusJakartaSansMed"
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                        const SizedBox(height: 10,),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: controller.hotDeals.map((deal) =>  Padding(
                                              padding: const EdgeInsets.only(right: 10),
                                              child: InkWell(
                                                onTap: () {
                                                  Get.offAndToNamed(
                                                    detailScreen,
                                                    arguments: {
                                                      "details": deal
                                                    }
                                                  );
                                                },
                                                child: Container(
                                                  // height: 200, 
                                                  width: 170,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                      borderRadius: BorderRadius.circular(16),
                                                  ),
                                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                                                  child: Column(
                                                    children: [
                                                      CachedNetworkImage(
                                                        imageUrl: deal["image"],
                                                        height: 50,
                                                        width: 50,
                                                        progressIndicatorBuilder: (context, url, downloadProgress) => const Center(
                                                          child: Center(
                                                            child: SpinKitFadingCircle(
                                                              color: Color(0xff265682),
                                                              size: 50,
                                                            ),
                                                          )
                                                        ),
                                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                                      ),
                                                      const SizedBox(height: 10,),
                                                      FutureBuilder(
                                                        future: translate(deal["name"]),
                                                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                                            return const Text(
                                                              "Loading...",
                                                              style: TextStyle(
                                                                color: Color(0xff292A2E),
                                                                fontSize: 12,
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
                                                      const SizedBox(height: 10,),
                                                      RichText(
                                                        text: TextSpan(
                                                          text: "\$ ${number.format(int.parse(deal["price"].toString().split(".").first))}",
                                                          style: const TextStyle(
                                                            color: Color(0xff1B5EC9),
                                                            fontSize: 14,
                                                            fontFamily: "PlusJakartaSansBold"
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )).toList(),
                                          ),
                                        ),
                                        const SizedBox(height: 50,),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        )
                      ),
                      child: Row(
                        children: [
                          (controller.carts.map((element) => element["name"])).toList().contains(details["name"])?
                          SizedBox():
                          InkWell(
                            onTap: () {
                              controller.addCart(details["id"],details);
                            },
                            child: SvgPicture.asset(
                              "assets/images/CartButton.svg"
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 56,
                              width: Get.width,
                              child: ElevatedButton(
                                onPressed: (){
                                  String key = controller.carts.where((element) => element["name"] == details["name"]).toList()[0]["key"];

                                  (controller.carts.map((element) => element["name"])).toList().contains(details["name"])?
                                   Get.toNamed(
                                    addressOrderScreen,
                                    arguments: {
                                      'key': key,
                                      "details": details,
                                    }
                                  ):
                                  Fluttertoast.showToast(
                                    msg: "Add Item to cart",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.TOP,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                  );
                                }, 
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  backgroundColor: const Color(0xff053969)
                                ),
                                child:  FutureBuilder(
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
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}