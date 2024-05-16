import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LeaveReview {
  static showLeaveReview(){
    Get.bottomSheet(
      Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: const BoxDecoration(
          color: Color(0xffF5F5F5),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 4,
                width: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.2)
                ),
              ),
            ),
            const SizedBox(height: 20,),
            const Text(
              "Leave a Review",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff212121),
                fontFamily: "PlusJakartaSansBold"
              ),
            ),
            const SizedBox(height: 10,),
            const Divider(
              color: Color(0xffEEEEEE),
              thickness: 2,
            ),
            const SizedBox(height: 20,),
            Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  32
                )
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Image.asset(
                      "assets/images/earphone.png"
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Sonia Headphone",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff212121),
                            fontFamily: "PlusJakartaSansBold"
                          ),
                        ),
                        const SizedBox(height: 10,),
                        const Text(
                          "Color | Qty = 1",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff616161),
                            fontFamily: "PlusJakartaSansMed"
                          ),
                        ),
                        const SizedBox(height: 10,),
                        SvgPicture.asset(
                          "assets/images/completedButton.svg"
                        ),
                        const SizedBox(height: 10,),
                        const Text(
                          "\$ 325.00",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff212121),
                            fontFamily: "PlusJakartaSansBold"
                          ),
                        ),
                      ],
                    )
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            const Divider(
              color: Color(0xffEEEEEE),
              thickness: 2,
            ),
            const SizedBox(height: 20,),
            const Text(
              "How is your order?",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff212121),
                fontFamily: "PlusJakartaSansBold"
              ),
            ),
            const SizedBox(height: 10,),
            const Text(
              "Please give your rating & also your review...",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff616161),
                fontFamily: "PlusJakartaSansMed"
              ),
            ),
            const SizedBox(height: 20,),
            RatingBar.builder(
              initialRating: 4,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Iconsax.star1,
                color: Color(0xff101010),
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: TextEditingController(text: "Very good product & fast delivery!"),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xff35383F)
                  )
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xff35383F)
                  )
                ),
                suffixIcon: const Icon(
                  Iconsax.gallery,
                  color: Color(0xff35383F)
                )
              ),
            ),
            const SizedBox(height: 20,),
            const Divider(
              color: Color(0xffEEEEEE),
              thickness: 2,
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 56,
                    width: Get.width,
                    child: ElevatedButton(
                      onPressed: (){
                        // Get.toNamed(emailVerification);
                      }, 
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        backgroundColor: const Color(0xffE7E7E7)
                      ),
                      child: const Text(
                        "Cancel",
                        style:  TextStyle(
                          color: Color(0xff35383F),
                          fontSize: 16,
                          fontFamily: "PlusJakartaSansMed"
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20,),
                Expanded(
                  child: SizedBox(
                    height: 56,
                    width: Get.width,
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
                        "Submit",
                        style:  TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: "PlusJakartaSansMed"
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      isScrollControlled: true
    );
  }
}