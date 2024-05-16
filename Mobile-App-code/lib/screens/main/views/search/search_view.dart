import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerce/controller/home_state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:translator/translator.dart';

import '../../../../routes/app/app_route_names.dart';
import '../../../../storage/secureStorage.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {

    var number = NumberFormat("#,###");

    Future<String> translate(String text) async{
      String language = await LocalStorage().fetchLanguage();
      Translation translatedText = await text.translate(to: language == ""? "en" : language);
      log(translatedText.toString());
      return translatedText.toString();
    }

    return GetBuilder<HomeStateController>(
      builder: (controller) {
        return DefaultTabController(
          length: controller.uniqueCategoryNames.length,
          child: Scaffold(
            body: SizedBox(
              height: Get.height,
              width: Get.width,
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          controller.updateFilteredProducts();
                          Get.toNamed(searchedProductScreen);
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withAlpha(30),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xffEAEAEA)
                            ),
                            borderRadius: BorderRadius.circular(34)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xffEAEAEA)
                            ),
                            borderRadius: BorderRadius.circular(34)
                          ),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(left: 10,),
                            child: Icon(
                              Iconsax.search_normal_1,
                              color: Color(0xff053969),
                            ),
                          ),
                          hintText: "Search groceries",
                          hintStyle: const TextStyle(
                            color: Color(0xffBCBDC0),
                            fontSize: 16
                          )
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    TabBar(
                      padding: const EdgeInsets.only(left: 20),
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
                    const SizedBox(height: 20,),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GridView.builder(
                          itemCount: controller.categoriesList.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisExtent: 220,
                            mainAxisSpacing: 15
                          ), 
                          itemBuilder: (context, index){
                            return Container(
                              child: Center(
                                child: InkWell(                               
                                  onTap: () {
                                    Get.toNamed(
                                      detailScreen,
                                      arguments: {
                                        "details": controller.categoriesList[index]
                                      }
                                    );
                                  },
                                  child: Container(
                                    // height: 215,
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
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                        CachedNetworkImage(
                                          imageUrl: controller.categoriesList[index]["image"],
                                          height: 100,
                                          width: 100,
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
                                          const SizedBox(height: 15,),
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
                                          Text(
                                            "\$ ${number.format(int.parse(controller.categoriesList[index]["price"].toString().split(".").first))}",
                                            style: const TextStyle(
                                              color: Color(0xff1B5EC9),
                                              fontSize: 14,
                                              fontFamily: "PlusJakartaSansBold"
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
                        ),
                      ),
                    ),
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