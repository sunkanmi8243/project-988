import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../controller/home_state_controller.dart';

class ScanProductScreen extends StatefulWidget {
  const ScanProductScreen({super.key});

  @override
  State<ScanProductScreen> createState() => _ScanProductScreenState();
}

class _ScanProductScreenState extends State<ScanProductScreen> {

  late CameraController controller;
  late List<CameraDescription> _cameras;
  getCameras()async {
    _cameras = await availableCameras();

    controller = CameraController(_cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
          // Handle access errors here.
            break;
          default:
          // Handle other errors here.
            break;
        }
      }
    });
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    getCameras();
  }


  @override
  Widget build(BuildContext context) {

    return GetBuilder<HomeStateController>(
      builder: (homeController) {
        return Scaffold(
          body: SizedBox(
            height: Get.height,
            width: Get.width,
            child: SafeArea(
              bottom: false,
              child: Column(
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
                                "Scan Product",
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
                  Expanded(
                    child: Container(
                      color: const Color(0xff2D3C52).withOpacity(0.34),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 8,
                            child: (!controller.value.isInitialized)?
                            Container(color: Colors.black,):
                            SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: CameraPreview(
                                controller,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: SizedBox(
                                  height: 56,
                                  width: Get.width,
                                  child: ElevatedButton(
                                    onPressed: () async{
                                      var image = await controller.takePicture();
                                      print(image.path);
                                      (image.path.isEmpty)?
                                          null:
                                          homeController.searchImage(File(image.path));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      backgroundColor: const Color(0xff053969)
                                    ),
                                    child: (homeController.isLoading)?
                                    const Center(
                                      child: SpinKitFadingCircle(
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    )
                                        :
                                    const Text(
                                      "Scan Product",
                                      style:  TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: "PlusJakartaSansMed"
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

}