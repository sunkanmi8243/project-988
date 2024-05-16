import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {

    List<dynamic> notificationList = [
      {
        "isToday": true,
        "title": "30% Special Discount!",
        "description": "Special promotion only valid today",
        "type": "discount"
      },
      {
        "isToday": true,
        "title": "New Apple Promotion",
        "description": "Special promo to all apple device",
        "type": "apple"
      },
      {
        "isToday": false,
        "title": "Special Offer! 40% Off",
        "description": "Special offer for new account, valid until 20 Nov 2022",
        "type": "offer"
      },
      {
        "isToday": false,
        "title": "Special Offer! 50% Off",
        "description": "Special offer for new account, valid until 20 Nov 2022",
        "type": "offer"
      },
      {
        "isToday": false,
        "title": "Credit Card Connected",
        "description": "Special promotion only valid today",
        "type": "card"
      },
      {
        "isToday": false,
        "title": "Account Setup Successfull!",
        "description": "Special promotion only valid today",
        "type": "profile"
      },
    ];

    List<dynamic> todayList = notificationList.where((notifications) => notifications["isToday"] == true).toList();
    List<dynamic> yestardayList = notificationList.where((notifications) => notifications["isToday"] == false).toList();

    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.height,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      const Text(
                        "Your Notification",
                        style: TextStyle(
                          color: Color(0xff292A2E),
                          fontSize: 24,
                          fontFamily: "PlusJakartaSansBold"
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Today",
                        style: TextStyle(
                          color: Color(0xff7C7D82),
                          fontSize: 14,
                          fontFamily: "PlusJakartaSansMed"
                        ),
                      ),
                      const SizedBox(height: 10,),
                      ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: todayList.length,
                        separatorBuilder: (context, index) {
                          return const Divider(
                            color: Color(0xffEAEAEA),
                            thickness: 1.5,
                          );
                        },
                        itemBuilder:(context, index) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: SvgPicture.asset(
                              (todayList[index]["type"] == "discount")?
                              "assets/images/discount.svg":
                              "assets/images/apple.svg"
                            ),
                            title: Text(
                              todayList[index]["title"],
                              style: const TextStyle(
                                color: Color(0xff292A2E),
                                fontSize: 16,
                                fontFamily: "PlusJakartaSansMed"
                              ),
                            ),
                            subtitle: Text(
                              todayList[index]["description"],
                              style: const TextStyle(
                                color: Color(0xff7C7D82),
                                fontSize: 14,
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                const Divider(
                  color: Color(0xffF0F1F5),
                  thickness: 4,
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Yesterday",
                        style: TextStyle(
                          color: Color(0xff7C7D82),
                          fontSize: 14,
                          fontFamily: "PlusJakartaSansMed"
                        ),
                      ),
                      const SizedBox(height: 10,),
                      ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: yestardayList.length,
                        separatorBuilder: (context, index) {
                          return const Divider(
                            color: Color(0xffEAEAEA),
                            thickness: 1.5,
                          );
                        },
                        itemBuilder:(context, index) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: SvgPicture.asset(
                              (yestardayList[index]["type"] == "offer")?
                              "assets/images/discount.svg":
                              (yestardayList[index]["type"] == "card")?
                              "assets/images/card.svg":
                              "assets/images/user.svg"
                            ),
                            title: Text(
                              yestardayList[index]["title"],
                              style: const TextStyle(
                                color: Color(0xff292A2E),
                                fontSize: 16,
                                fontFamily: "PlusJakartaSansMed"
                              ),
                            ),
                            subtitle: Text(
                              yestardayList[index]["description"],
                              style: const TextStyle(
                                color: Color(0xff7C7D82),
                                fontSize: 14,
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}