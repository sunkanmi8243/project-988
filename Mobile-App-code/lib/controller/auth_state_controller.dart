import 'dart:async';
import 'dart:developer';

import 'package:commerce/routes/app/app_route_names.dart';
import 'package:commerce/widgets/bottomsheets/otpSuccess.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../services/auth/auth_services.dart';
import '../storage/secureStorage.dart';

class AuthStateController extends GetxController {

  // INSTANT VARIABLES
  bool _hidePassword = false;
  String _selectedMethod = "1";
  String _email = "";
  String _password = "";
  String _otp = "";
  String _passwordConfirm = "";
  bool _isLoading = false;
  Timer? _timer;
  int _counter = 60; 


  // GETTERS
  bool get hidePassword => _hidePassword;
  String get selectedMethod => _selectedMethod;
  String get email => _email;
  String get password => _password;
  String get otp => _otp;
  String get passwordConfirm => _passwordConfirm;
  bool get isLoading => _isLoading;


  // SETTERS
  updateHidePassword(){
    _hidePassword = !_hidePassword;
    update();
  }
  updateSelectedMethod(value){
    _selectedMethod = value;
    update();
  }
  updateEmail(value){
    _email = value;
    update();
  }
  updatePassword(value){
    _password = value;
    update();
  }
  updatePasswordConfirm(value){
    _passwordConfirm = value;
    update();
  }
  updateIsLoading(value){
    _isLoading = value;
    update();
  }
  updateOtp(value){
    _otp = value;
    update();
  }
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        _counter--;
      } else {
        // Trigger your resend email function here
        resendVerifyEmail();
        // Reset the counter to 60 seconds
        _counter = 60;
      }
    });

    update();
  }

  // API CALLS

  Future login() async{
    updateIsLoading(true);

    var data = {
      "email" : _email,
      "password" : _password
    };

    await LocalStorage().storeEmail(_email);

    var response = await AuthServices().loginService(data);
    var responseData = response!.data;
    log(responseData.toString());

    if(response.statusCode == 200 || response.statusCode == 201){
      updateIsLoading(false);

      await LocalStorage().storeUserToken(responseData["data"]["access_token"]);

      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

      Get.offAllNamed(holder);

    }else {
      updateIsLoading(false);

      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
  }

  Future register() async{
    updateIsLoading(true);

    var data = {
      "email" : _email,
      "password" : _password,
      "password_confirmation": _passwordConfirm
    };
    
    await LocalStorage().storeEmail(_email)  ;
     var response = await AuthServices().registerService(data);
    var responseData = response!.data;
    log(responseData.toString());

    if(response.statusCode == 200 || response.statusCode == 201){
      updateIsLoading(false);

      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

      Get.toNamed(
        emailVerification,
        arguments: {
          "email": _email
        }
      );

    }else {
      updateIsLoading(false);

      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
  }

  Future verifyEmail() async{
    updateIsLoading(true);

    String email = await LocalStorage().fetchEmail();

    var response = await AuthServices().verifyEmailCodeService(email, _otp);
    var responseData = response!.data;
    log(responseData.toString());

    if(response.statusCode == 200 || response.statusCode == 201){
      updateIsLoading(false);

      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

      OtpSuccess.showOtpSuccess();

    }else {
      updateIsLoading(false);

      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

    }
  }

  Future verifyPasswordEmail() async{
    updateIsLoading(true);

    String email = await LocalStorage().fetchEmail();

    var response = await AuthServices().verifyEmailCodeService(email, _otp);
    var responseData = response!.data;
    log(responseData.toString());

    if(response.statusCode == 200 || response.statusCode == 201){
      updateIsLoading(false);

      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

      Get.toNamed(
        resetPasswordScreen,
      );

    }else {
      updateIsLoading(false);

      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

    }
  }

  Future resendVerifyEmail() async{
    updateIsLoading(true);

    String email = await LocalStorage().fetchEmail();

    var data = {
      "email" : email,
    };

    var response = await AuthServices().resendEmailVerificationService(data);
    var responseData = response!.data;
    log(responseData.toString());

    if(response.statusCode == 200 || response.statusCode == 201){
      updateIsLoading(false);

      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

    }else {
      updateIsLoading(false);

      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
  }

  Future forgotPassword(email) async{
    updateIsLoading(true);

    var data = {
      "email" : email,
    };

    var response = await AuthServices().forgotPassword(data);
    var responseData = response!.data;
    log(responseData.toString());

    if(response.statusCode == 200 || response.statusCode == 201){
      updateIsLoading(false);

      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

      Get.toNamed(
        otpVerification,
        arguments: {
          "email": email
        }
      );

    }else {
      updateIsLoading(false);

      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
  }

  Future resetPassword() async{
    updateIsLoading(true);

    String email = await LocalStorage().fetchEmail();

    var data = {
      "email": email,
      "password": _password,
      "password_confirmation": _passwordConfirm,
      "token": _otp
    };

    var response = await AuthServices().resetPassword(data);
    var responseData = response!.data;
    log(responseData);

    if(response.statusCode == 200 || response.statusCode == 201){
      updateIsLoading(false);

      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

      OtpSuccess.showOtpSuccess();

    }else {
      updateIsLoading(false);

      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
  }
  
}