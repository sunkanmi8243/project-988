import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerce/controller/home_state_controller.dart';
import 'package:commerce/storage/shared_pref.dart';
import 'package:commerce/widgets/bottomsheets/filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../../routes/app/app_route_names.dart';

class SearchedView extends StatelessWidget {
   SearchedView({super.key});
   
    var number = NumberFormat("#,###");

    final HomeStateController _homeStateController = Get.find<HomeStateController>();

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _homeStateController.updateRecentSearch();
    });

    return GetBuilder<HomeStateController>(
      builder: (controller) {
        return Scaffold(
          body: SizedBox(
            height: Get.height,
            width: Get.width,
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            Get.back();
                          },
                          child: SvgPicture.asset(
                            "assets/images/back.svg"
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: TextFormField(
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
                              ),
                            ),
                            onChanged: (value) {
                              controller.updateSearchValue(value);
                              controller.filterProduct(value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Padding(
                    padding:  const EdgeInsets.symmetric(horizontal: 20),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (controller.searchValue != "" || controller.searchValue2 != "")?
                          '"Result for ”${controller.searchValue}”':
                          "Recent Search",
                          style: const TextStyle(
                            color: Color(0xff7C7D82),
                            fontFamily: "PlusJakartaSansMed",
                            fontSize: 14
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            (controller.searchValue != "")?
                            null:
                            controller.clearRecentSearchList();
                          },
                          child: Text(
                            (controller.searchValue != "")?
                            "${controller.filteredProducts.length} founds":
                            "Clear All",
                            style: const TextStyle(
                              color: Color(0xff1B5EC9),
                              fontFamily: "PlusJakartaSansMed",
                              fontSize: 14
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Expanded(
                    child: (controller.searchValue != "")?
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GridView.builder(
                        itemCount: controller.filteredProducts.length,
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
                                  controller.addToRecentSearch(jsonEncode(controller.filteredProducts[index]));
                                  Get.toNamed(
                                    detailScreen,
                                    arguments: {
                                      "details": controller.filteredProducts[index]
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
                                          imageUrl: controller.filteredProducts[index]["image"],
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
                                        Text(
                                          controller.filteredProducts[index]["name"],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Color(0xff292A2E),
                                            fontSize: 14,
                                            fontFamily: "PlusJakartaSansBold"
                                          ),
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(
                                          "\$ ${number.format(int.parse(controller.filteredProducts[index]["price"].toString().split(".").first))}",
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
                    )
                    :
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          controller.recentSearch.isEmpty?
                            const Center(
                              child: Text(
                                "No recent search",
                                style: TextStyle(
                                  color: Color(0xff292A2E),
                                  fontSize: 14,
                                  fontFamily: "PlusJakartaSansMed"
                                ),
                              ),
                            ):
                          Column(
                            children: 
                            List.generate(controller.recentSearch.length, (index) => 
                              ListTile(
                                onTap: () {
                                  Get.toNamed(
                                    detailScreen,
                                    arguments: {
                                      "details": jsonDecode(controller.recentSearch[index])
                                    }
                                  );
                                },
                                leading: const Icon(
                                  Iconsax.search_normal_1,
                                  color: Color(0xff053969),
                                ),
                                title: Text(
                                  jsonDecode(controller.recentSearch[index])["name"],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff292A2E)
                                  ),
                                ),
                              )
                            )
                          ),
                          const SizedBox(height: 15,),
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
                                  const Text(
                                    "Product Related",
                                    style: TextStyle(
                                      color: Color(0xff292A2E),
                                      fontSize: 18,
                                      fontFamily: "PlusJakartaSansBold"
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: controller.hotDeals.map((deal) =>  Padding(
                                        padding: const EdgeInsets.only(right: 10),
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
                                              Text(
                                                deal["name"],
                                                style: const TextStyle(
                                                  color: Color(0xff292A2E),
                                                  fontSize: 14,
                                                  fontFamily: "PlusJakartaSansBold"
                                                ),
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
                                      )).toList(),
                                    ),
                                  ),
                                  const SizedBox(height: 50,),
                                ],
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
          floatingActionButton: (controller.searchValue == "" || controller.searchValue2 == "")?
          null:
          FloatingActionButton.extended(
            onPressed: (){
              FilterBottomSheet.showFilterBottomSheet();
            }, 
            backgroundColor: const Color(0xff053969),
            label: const Text(
              "Filter",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: "PlusJakartaSansBold"
              ),
            ),
            icon: const Icon(
              Iconsax.filter5
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
      }
    );
  }
  ListTile _listTile(name){
    return ListTile(
      leading: const Icon(
        Iconsax.search_normal_1,
        color: Color(0xff053969),
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xff292A2E)
        ),
      ),
    );
  }
}