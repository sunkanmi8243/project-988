import 'package:aws_polly_api/polly-2016-06-10.dart';
import 'package:commerce/routes/app/app_route_names.dart';
import 'package:commerce/routes/app/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main(List<String> args) async{

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());


} 

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // Set your desired status bar color
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        )
    );

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Commerce",
      theme: ThemeData(
          colorScheme: const ColorScheme.light(primary: Color(0xff053969) ,secondary: Colors.white),
          scaffoldBackgroundColor: const Color(0xffFEFEFE),
          fontFamily: "PlusJakartaSans"
      ),
      initialRoute: splash,
      getPages: getPages,
    );
  }

}
