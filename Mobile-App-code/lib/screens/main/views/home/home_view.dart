import 'dart:developer';
import 'dart:io';

import 'package:aws_polly/aws_polly.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerce/controller/home_state_controller.dart';
import 'package:commerce/routes/app/app_route_names.dart';
import 'package:commerce/widgets/Popups/scan-model-choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shimmer/shimmer.dart';
import 'package:translator/translator.dart';

import '../../../../storage/secureStorage.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  final HomeStateController _homeStateController = Get.put(HomeStateController());

    @override
  State<HomeView> createState() => _HomeViewState();
}

enum TtsState { playing, stopped }

class _HomeViewState extends State<HomeView> {

  late FlutterTts _flutterTts;
  String? _tts;
  TtsState _ttsState = TtsState.stopped;

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
      "Hi there, ${widget._homeStateController.userModel.firstname} ${widget._homeStateController.userModel.lastname}, you have ${widget._homeStateController.userModel.walletBalance} dollars in your wallet");
    }

  Future<String> translate(String text) async{
    String language = await LocalStorage().fetchLanguage();
    Translation translatedText = await text.translate(to: language == ""? "en" : language);
    log(translatedText.toString());
    return translatedText.toString();
  }

  @override
  Widget build(BuildContext context) {

    var number = NumberFormat("#,###");

    return GetBuilder<HomeStateController>(
      builder: (controller) {
        return LoadingOverlay(
          isLoading: controller.isCartLoading || controller.isVoiceLoading,
          progressIndicator: const SpinKitFadingCircle(
            color: Color(0xff265682),
            size: 50,
          ),
          child: DefaultTabController(
            length: controller.uniqueCategoryNames.length,
            child: Scaffold(
              body: RefreshIndicator(
                onRefresh: controller.refreshProfile,
                child: SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Positioned(
                              left: 0,
                              right: 0,
                              child: Image.asset(
                                "assets/images/ECLIPSE.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 30,),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 20,
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
                                              const SizedBox(width: 6,),
                                               Expanded(
                                                 child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    FutureBuilder(
                                                      future: translate("Hi there,"),
                                                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                                          return const Text(
                                                            "Loading...",
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 12,
                                                            ),
                                                          ); // or any loading indicator
                                                        } else {
                                                          return Text(
                                                            snapshot.data ?? "",
                                                            style: const TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 12,
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                    const SizedBox(height: 5,),
                                                    Text(
                                                      "${controller.firstname.text} ${controller.lastname.text}",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontFamily: "PlusJakartaSansBold"
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                               )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Expanded(
                                                  child: Center(
                                                    child: InkWell(
                                                      onTap: () {
                                                        controller.getSpeech("Hi there, ${widget._homeStateController.userModel.firstname} ${widget._homeStateController.userModel.lastname}, you have ${widget._homeStateController.userModel.walletBalance} dollars in your wallet");
                                                      },
                                                      child: SvgPicture.asset(
                                                        "assets/images/Favorite.svg",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: InkWell(
                                                      onTap: () {
                                                        Get.toNamed(cartScreen);
                                                      },
                                                      child: Badge(
                                                        isLabelVisible: (controller.carts.isNotEmpty)?
                                                        true:false,
                                                        child: SvgPicture.asset(
                                                          "assets/images/Cart.svg",
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: InkWell(
                                                      onTap: () {
                                                        Get.toNamed(notificationScreen);
                                                      },
                                                      child: SvgPicture.asset(
                                                        "assets/images/Notification.svg",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 30,),
                                    Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(0, 20),
                                            blurRadius: 40,
                                            spreadRadius: 0,
                                            color: const Color(0xffC0C8E4).withOpacity(0.25)
                                          )
                                        ]
                                      ),
                                      child: TextFormField(
                                        onTap: () {
                                          FocusScope.of(context).requestFocus(FocusNode());
                                          Get.toNamed(searchedProductScreen);
                                        },
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white.withAlpha(30),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(34)
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(34)
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(34)
                                          ),
                                          prefixIcon: const Padding(
                                            padding: EdgeInsets.only(left: 10,),
                                            child: Icon(
                                              Iconsax.search_normal_1,
                                              color: Colors.white,
                                            ),
                                          ),
                                          hintText: "Search groceries",
                                          hintStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16
                                          )
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 30,),
                                    Container(
                                      // height: 178,
                                      width: Get.width,
                                      padding: const EdgeInsets.all(30),
                                      decoration: BoxDecoration(
                                        color: const Color(0xff265682),
                                        borderRadius: BorderRadius.circular(16)
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/images/bx-wallet.svg"
                                                    ),
                                                    const SizedBox(width: 5,),
                                                    FutureBuilder(
                                                      future: translate("Your\nBalance"),
                                                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                                          return const Text(
                                                            "Loading...",
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 12,
                                                            ),
                                                          ); // or any loading indicator
                                                        } else {
                                                          return Text(
                                                            snapshot.data ?? "",
                                                             style: const TextStyle(
                                                                color: Color(0xffF2F2F2),
                                                                fontSize: 8,
                                                                fontFamily: "PlusJakartaSansBold"
                                                              ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10,),
                                                Text(
                                                  "\$${number.format(int.parse(
                                                    (controller.userModel.walletBalance == null)?
                                                    "0":
                                                    controller.userModel.walletBalance.toString().split(".").first
                                                  ))}",
                                                  style: const TextStyle(
                                                    color: Color(0xffF2F2F2),
                                                    fontSize: 20,
                                                    fontFamily: "PlusJakartaSansBold"
                                                  ),
                                                ),
                                                const SizedBox(height: 15,),
                                                SvgPicture.asset(
                                                  "assets/images/Add money.svg"
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 20,),
                                          InkWell(
                                            onTap: () {
                                              Get.toNamed(scanProductScreen);
                                            },
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/images/Qr Code.svg"
                                                ),
                                                const SizedBox(height: 5,),
                                                FutureBuilder(
                                                  future: translate("Scan Product"),
                                                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                                      return const Text(
                                                        "Loading...",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                        ),
                                                      ); // or any loading indicator
                                                    } else {
                                                      return Text(
                                                        snapshot.data ?? "",
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                        (!controller.isLoading)?
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 30,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  FutureBuilder(
                                    future: translate("Hot deals🔥"),
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
                                            fontSize: 18,
                                            fontFamily: "PlusJakartaSansBold"
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 24,
                                        width: 24,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffF2F2F2),
                                          borderRadius: BorderRadius.circular(4)
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "02",
                                            style: TextStyle(
                                              color: Color(0xff292A2E),
                                              fontSize: 12,
                                              fontFamily: "PlusJakartaSansBold"
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5,),
                                      const Text(
                                        ":",
                                        style: TextStyle(
                                          color: Color(0xff292A2E),
                                          fontSize: 12,
                                          fontFamily: "PlusJakartaSansBold"
                                        ),
                                      ),
                                      const SizedBox(width: 5,),
                                      Container(
                                        height: 24,
                                        width: 24,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffF2F2F2),
                                          borderRadius: BorderRadius.circular(4)
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "12",
                                            style: TextStyle(
                                              color: Color(0xff292A2E),
                                              fontSize: 12,
                                              fontFamily: "PlusJakartaSansBold"
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5,),
                                      const Text(
                                        ":",
                                        style: TextStyle(
                                          color: Color(0xff292A2E),
                                          fontSize: 12,
                                          fontFamily: "PlusJakartaSansBold"
                                        ),
                                      ),
                                      const SizedBox(width: 5,),
                                      Container(
                                        height: 24,
                                        width: 24,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffF2F2F2),
                                          borderRadius: BorderRadius.circular(4)
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "00",
                                            style: TextStyle(
                                              color: Color(0xff292A2E),
                                              fontSize: 12,
                                              fontFamily: "PlusJakartaSansBold"
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 10,),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: controller.hotDeals.map((deal) =>  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: InkWell(
                                      onTap: () {
                                        Get.toNamed(
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
                                                    size: 30,
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
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: RichText(
                                                    maxLines: 1,
                                                    text: TextSpan(
                                                      text: "\$ ${number.format(int.parse(deal["price"].toString().split(".").first))} ",
                                                      style: const TextStyle(
                                                        color: Color(0xff1B5EC9),
                                                        fontSize: 14,
                                                        fontFamily: "PlusJakartaSansBold"
                                                      ),
                                                      // children: [
                                                      //   TextSpan(
                                                      //     text: " \$ ${deal["slashed"]}",
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
                                                ),
                                                (controller.carts.map((element) => element["name"])).toList().contains(deal["name"])?
                                                const SizedBox():
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      controller.addCart(deal["id"],deal);
                                                    },
                                                    child: SvgPicture.asset(
                                                      "assets/images/Add.svg"
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )).toList(),
                                ),
                              ),
                              const SizedBox(height: 30,),
                              FutureBuilder(
                                future: translate("Categories"),
                                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Text(
                                      "Loading...",
                                      style: TextStyle(
                                        color: Color(0xff292A2E),
                                        fontSize: 14,
                                      ),
                                    ); // or any loading indicator
                                  } else {
                                    return Text(
                                      snapshot.data ?? "",
                                      style: const TextStyle(
                                        color: Color(0xff292A2E),
                                        fontSize: 18,
                                        fontFamily: "PlusJakartaSansBold"
                                      ),
                                    );
                                  }
                                },
                              ),
                              const SizedBox(height: 15,),
                              TabBar(
                                tabAlignment: TabAlignment.start,
                                isScrollable: true,
                                onTap: (value) {
                                  controller.updateCategoryTab(controller.uniqueCategoryNames.toList()[value]);
                                },
                                indicator: BoxDecoration(
                                  color: const Color(0xff053969),
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                indicatorSize: TabBarIndicatorSize.tab,
                                labelColor: Colors.white,
                                tabs: controller.uniqueCategoryNames.map((name) => 
                                  FutureBuilder(
                                    future: translate(name),
                                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Tab(
                                          text: "Loading",
                                        );
                                      } else {
                                        return Tab(
                                          text: snapshot.data ?? "",
                                        );
                                      }
                                    },
                                  ),
                                ).toList(),
                              ),
                              const SizedBox(height: 15,),
                              ListView.separated(
                                primary: false,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index){
                                  return InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                        detailScreen,
                                        arguments: {
                                          "details": controller.categoriesList[index]
                                        }
                                      );
                                    },
                                    child: Container(
                                      width: Get.width,
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(0, 20),
                                            blurRadius: 32,
                                            spreadRadius: -8,
                                            color: const Color(0xff576F85).withOpacity(0.2)
                                          )
                                        ]
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 7,
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 64,
                                                  width: 64,
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xffF3F6FB),
                                                    borderRadius: BorderRadius.circular(12)
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl: controller.categoriesList[index]["image"],
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
                                                        future: translate(controller.categoriesList[index]["name"]),
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
                                                      const SizedBox(height: 5,),
                                                      RichText(
                                                        text: TextSpan(
                                                          text: "\$ ${number.format(int.parse(controller.categoriesList[index]["price"].toString().split(".").first))} ",
                                                          style: const TextStyle(
                                                            color: Color(0xff1B5EC9),
                                                            fontSize: 14,
                                                            fontFamily: "PlusJakartaSansBold"
                                                          ),
                                                          // children: [
                                                          //   TextSpan(
                                                          //     text: " \$ ${controller.categories[index]["slashed"]}",
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
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Center(
                                              child: SizedBox(
                                                height: 32,
                                                // width: 90,
                                                child: ElevatedButton(
                                                  onPressed: (){
                                                    controller.addCart(controller.categories[index]["id"], controller.categories[index]);
                                                  }, 
                                                  style: ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(50),
                                                    ),
                                                    backgroundColor: const Color(0xff053969)
                                                  ),
                                                  child: FutureBuilder(
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
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }, 
                                separatorBuilder: (context, index){
                                  return const SizedBox(
                                    height: 15,
                                  );
                                }, 
                                itemCount: controller.categoriesList.length
                              ),
                              
                              const SizedBox(height: 30,)
                            ],
                          ),
                        )
                          
                          
                          
                        :
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Hot deals🔥",
                                      style: TextStyle(
                                        color: Color(0xff292A2E),
                                        fontSize: 18,
                                        fontFamily: "PlusJakartaSansBold"
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 24,
                                          width: 24,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffF2F2F2),
                                            borderRadius: BorderRadius.circular(4)
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "02",
                                              style: TextStyle(
                                                color: Color(0xff292A2E),
                                                fontSize: 12,
                                                fontFamily: "PlusJakartaSansBold"
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5,),
                                        const Text(
                                          ":",
                                          style: TextStyle(
                                            color: Color(0xff292A2E),
                                            fontSize: 12,
                                            fontFamily: "PlusJakartaSansBold"
                                          ),
                                        ),
                                        const SizedBox(width: 5,),
                                        Container(
                                          height: 24,
                                          width: 24,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffF2F2F2),
                                            borderRadius: BorderRadius.circular(4)
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "12",
                                              style: TextStyle(
                                                color: Color(0xff292A2E),
                                                fontSize: 12,
                                                fontFamily: "PlusJakartaSansBold"
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5,),
                                        const Text(
                                          ":",
                                          style: TextStyle(
                                            color: Color(0xff292A2E),
                                            fontSize: 12,
                                            fontFamily: "PlusJakartaSansBold"
                                          ),
                                        ),
                                        const SizedBox(width: 5,),
                                        Container(
                                          height: 24,
                                          width: 24,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffF2F2F2),
                                            borderRadius: BorderRadius.circular(4)
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "00",
                                              style: TextStyle(
                                                color: Color(0xff292A2E),
                                                fontSize: 12,
                                                fontFamily: "PlusJakartaSansBold"
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: controller.hotDeals.map((deal) =>  Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: InkWell(
                                        onTap: () {
                                          Get.toNamed(
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
                                              Image.asset(
                                                "assets/images/indomie1.png",
                                                height: 100,
                                                width: 100,
                                              ),
                                              const SizedBox(height: 10,),
                                              const Text(
                                                "Indomie",
                                                style:  TextStyle(
                                                  color: Color(0xff292A2E),
                                                  fontSize: 14,
                                                  fontFamily: "PlusJakartaSansBold"
                                                ),
                                              ),
                                              const SizedBox(height: 10,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      text: "\$ ${deal["price"]} ",
                                                      style: const TextStyle(
                                                        color: Color(0xff1B5EC9),
                                                        fontSize: 14,
                                                        fontFamily: "PlusJakartaSansBold"
                                                      ),
                                                      // children: [
                                                      //   TextSpan(
                                                      //     text: " \$ ${deal["slashed"]}",
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
                                                  InkWell(
                                                    onTap: () {
                                                      controller.addToCart(deal);
                                                    },
                                                    child: SvgPicture.asset(
                                                      "assets/images/Add.svg"
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )).toList(),
                                  ),
                                ),
                                const SizedBox(height: 30,),
                                const Text(
                                  "Categories",
                                  style: TextStyle(
                                    color: Color(0xff292A2E),
                                    fontSize: 18,
                                    fontFamily: "PlusJakartaSansBold"
                                  ),
                                ),
                                const SizedBox(height: 15,),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(left: 5, right: 20, top: 5, bottom: 5),
                                        decoration: BoxDecoration(
                                          color: const Color(0xff053969),
                                          borderRadius: BorderRadius.circular(30)
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 32,
                                              width: 32,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white
                                              ),
                                              child: const Icon(
                                                Iconsax.menu5,
                                                size: 20,
                                              ),
                                            ),
                                            const SizedBox(width: 10,),
                                            const Text(
                                              "All",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      Container(
                                        padding: const EdgeInsets.only(left: 5, right: 20, top: 5, bottom: 5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          border: Border.all(
                                            color: const Color(0xffF4F4F4)
                                          )
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 32,
                                              width: 32,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xffF3F6FB)
                                              ),
                                              child: SvgPicture.asset(
                                                "assets/images/lap.svg"
                                              )
                                            ),
                                            const SizedBox(width: 10,),
                                            const Text(
                                              "Laptop",
                                              style: TextStyle(
                                                color: Color(0xff292A2E),
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      Container(
                                        padding: const EdgeInsets.only(left: 5, right: 20, top: 5, bottom: 5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          border: Border.all(
                                            color: const Color(0xffF4F4F4)
                                          )
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 32,
                                              width: 32,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xffF3F6FB)
                                              ),
                                              child: SvgPicture.asset(
                                                "assets/images/ear.svg"
                                              )
                                            ),
                                            const SizedBox(width: 10,),
                                            const Text(
                                              "Accessories",
                                              style: TextStyle(
                                                color: Color(0xff292A2E),
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15,),
                                ListView.separated(
                                  primary: false,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index){
                                    return Container(
                                      width: Get.width,
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(0, 20),
                                            blurRadius: 32,
                                            spreadRadius: -8,
                                            color: const Color(0xff576F85).withOpacity(0.2)
                                          )
                                        ]
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 7,
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 64,
                                                  width: 64,
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xffF3F6FB),
                                                    borderRadius: BorderRadius.circular(12)
                                                  ),
                                                  child: Image.asset(
                                                    "assets/images/indomie.png"
                                                  )
                                                ),
                                                const SizedBox(width: 15,),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "",
                                                        style: const TextStyle(
                                                          color: Color(0xff292A2E),
                                                          fontSize: 14,
                                                          fontFamily: "PlusJakartaSansBold"
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5,),
                                                      RichText(
                                                        text: const TextSpan(
                                                          text: "\$  ",
                                                          style: TextStyle(
                                                            color: Color(0xff1B5EC9),
                                                            fontSize: 14,
                                                            fontFamily: "PlusJakartaSansBold"
                                                          ),
                                                          // children: [
                                                          //   TextSpan(
                                                          //     text: " \$ ${controller.categories[index]["slashed"]}",
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
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Center(
                                              child: SizedBox(
                                                height: 32,
                                                width: 90,
                                                child: ElevatedButton(
                                                  onPressed: (){
                                                    // Get.toNamed(emailVerification);
                                                  }, 
                                                  style: ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(50),
                                                    ),
                                                    backgroundColor: const Color(0xff053969)
                                                  ),
                                                  child: const Text(
                                                    "Buy Now",
                                                    style:  TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontFamily: "PlusJakartaSansMed"
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }, 
                                  separatorBuilder: (context, index){
                                    return const SizedBox(
                                      height: 15,
                                    );
                                  }, 
                                  itemCount: 3
                                ),
                                
                                const SizedBox(height: 30,)
                              ],
                            ),
                          ),
                        )
                    
                      ],
                    ),
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