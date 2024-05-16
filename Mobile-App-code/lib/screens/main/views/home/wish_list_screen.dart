import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../routes/app/app_route_names.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {

 List<Map<String, dynamic>> products = [
      {
        "image": "assets/images/dano.png",
        "title": "Dano Milk (Extra Cream)",
        "price": "1240",
      },
      {
        "image": "assets/images/milo.png",
        "title": "Milo Beverege",
        "price": "462",
      },
      {
        "image": "assets/images/indomie1.png",
        "title": "Indomie Chicken Flavour",
        "price": "240",
      },
      {
        "image": "assets/images/corn.png",
        "title": "Sweet Corn Flakes With Sugar",
        "price": "108",
      },
      {
        "image": "assets/images/indomie2.png",
        "title": "Indomie Onion Flavour",
        "price": "240",
      },
      {
        "image": "assets/images/oil.png",
        "title": "Power Oil 50g Version",
        "price": "108",
      },
    ];

    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                            "Wishlist",
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
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 5, right: 20, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xff292A2E),
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
              ),
              const SizedBox(height: 20,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    itemCount: products.length,
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
                                  "title": products[index]["title"],
                                  "image": products[index]["image"],
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
                              child: Column(
                                children: [
                                  Image.asset(
                                    products[index]["image"],
                                    height: 100,
                                    width: 100,
                                  ),
                                  const SizedBox(height: 15,),
                                  Text(
                                    products[index]["title"],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xff292A2E),
                                      fontSize: 14,
                                      fontFamily: "PlusJakartaSansBold"
                                    ),
                                  ),
                                  const SizedBox(height: 5,),
                                  Text(
                                    "\$ ${products[index]["price"]}",
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
                      );
                    }
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}