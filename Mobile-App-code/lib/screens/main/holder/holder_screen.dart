import 'package:commerce/controller/app_state_controller.dart';
import 'package:commerce/controller/home_state_controller.dart';
import 'package:commerce/widgets/bottomsheets/more_bottom_sheet.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HolderScreen extends StatelessWidget {
  HolderScreen({super.key});

  final AppStateController _appStateController = Get.put(AppStateController());
  final HomeStateController _homeStateController = Get.put(HomeStateController());

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _homeStateController.getProfile(context);
      _homeStateController.getProducts();
      _homeStateController.getCarts();
      _homeStateController.updateCartKey();
      _homeStateController.updateSelectedLanguage1();
    });

    return GetBuilder<AppStateController>(
      builder: (controller) {
        return Scaffold(
          body: DoubleBackToCloseApp(
            child: controller.views[controller.currentView],
            snackBar: const SnackBar(
              content: Text('Tap back again to leave'),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            padding: EdgeInsets.zero,
            color: Colors.white,
            surfaceTintColor: Colors.white,
            child: SizedBox(
              height: 70,
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      controller.updateCurrentView(0);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          (controller.currentView == 0)?
                          Iconsax.home_25
                          :
                          Iconsax.home_2,
                          color: (controller.currentView == 0)?
                            const Color(0xff053969)
                            :
                          const Color(0xff989E9F),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          "Home",
                          style: TextStyle(
                            color: (controller.currentView == 0)?
                            const Color(0xff053969)
                            :
                            const Color(0xff989E9F),
                            fontSize: 11,
                            fontFamily:(controller.currentView == 0)?
                            "PlusJakartaSansBold"
                            : 
                            "PlusJakartaSans"
                          ),
                        )
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.updateCurrentView(1);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          (controller.currentView == 1)?
                          Icons.search
                          :
                          Icons.search,
                          color: (controller.currentView == 1)?
                            const Color(0xff053969)
                            :
                          const Color(0xff989E9F),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          "Browse",
                          style: TextStyle(
                            color: (controller.currentView == 1)?
                            const Color(0xff053969)
                            :
                            const Color(0xff989E9F),
                            fontSize: 11,
                            fontFamily:(controller.currentView == 1)?
                            "PlusJakartaSansBold"
                            : 
                            "PlusJakartaSans"
                          ),
                        )
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.updateCurrentView(2);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          (controller.currentView == 2)?
                          Iconsax.shopping_bag5
                          :
                          Iconsax.shopping_bag,
                          color: (controller.currentView == 2)?
                            const Color(0xff053969)
                            :
                          const Color(0xff989E9F),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          "Cart",
                          style: TextStyle(
                            color: (controller.currentView == 2)?
                            const Color(0xff053969)
                            :
                            const Color(0xff989E9F),
                            fontSize: 11,
                            fontFamily:(controller.currentView == 2)?
                            "PlusJakartaSansBold"
                            : 
                            "PlusJakartaSans"
                          ),
                        )
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.updateCurrentView(3);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          (controller.currentView == 3)?
                          Iconsax.profile_circle5
                          :
                          Iconsax.profile_circle,
                          color: (controller.currentView == 3)?
                            const Color(0xff053969)
                            :
                          const Color(0xff989E9F),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          "Profile",
                          style: TextStyle(
                            color: (controller.currentView == 3)?
                            const Color(0xff053969)
                            :
                            const Color(0xff989E9F),
                            fontSize: 11,
                            fontFamily:(controller.currentView == 3)?
                            "PlusJakartaSansBold"
                            : 
                            "PlusJakartaSans"
                          ),
                        )
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      MoreBottomSheet.showMoreBottomeSheet(context);
                    },
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.menu_1,
                          color: 
                           Color(0xff989E9F),
                        ),
                         SizedBox(height: 5,),
                         Text(
                          "More",
                          style: TextStyle(
                            color: 
                             Color(0xff989E9F),
                            fontSize: 11,
                            fontFamily:
                            "PlusJakartaSans"
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}