import 'package:commerce/routes/app/app_route_names.dart';
import 'package:commerce/widgets/Popups/scan-model-choice.dart';
import 'package:commerce/widgets/bottomsheets/language-sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MoreBottomSheet {
  static showMoreBottomeSheet(context){
    Get.bottomSheet(
      Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: const BoxDecoration(
          color: Colors.white,
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
            const SizedBox(height: 30,),
            ListTile(
              onTap: () {
                Get.back();
                Get.toNamed(scanProductScreen);
              },
              contentPadding: EdgeInsets.zero,
              leading: SvgPicture.asset("assets/images/scan.svg"),
              title: const Text(
                "Scan Product",
                style:  TextStyle(
                  color: Color(0xff292A2E),
                  fontSize: 16,
                  fontFamily: "PlusJakartaSansBold"
                ),
              ),
              trailing: const Icon(
                Iconsax.arrow_right_3,
                size: 20,
                color: Color(0xff053969),
              ),
            ),
            const Divider(
              color: Color(0xffF0F1F5),
            ),
            ListTile(
              onTap: () {
                Get.back();
                LanguageSheet.showLanguageSheet();
              },
              contentPadding: EdgeInsets.zero,
              leading: SvgPicture.asset(
                "assets/images/language.svg"
              ),
              title: const Text(
                "Language",
                style:  TextStyle(
                  color: Color(0xff292A2E),
                  fontSize: 16,
                  fontFamily: "PlusJakartaSansBold"
                ),
              ),
              trailing: const Icon(
                Iconsax.arrow_right_3,
                size: 20,
                color: Color(0xff053969),
              ),
            ),
            const SizedBox(height: 30,),
          ],
        ),
      ),
      isScrollControlled: true
    );
  }
}