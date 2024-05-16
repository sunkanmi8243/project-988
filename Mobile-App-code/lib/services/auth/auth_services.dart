import 'dart:developer';

import 'package:dio/dio.dart';

import '../../routes/api/api_routes.dart';

class AuthServices {

  final Dio _dio = Dio();

  // LOGIN
  Future<Response?> loginService(data) async{
    try {
      String url = "$baseUrl$loginRoute";
      log(url);
      var response = await _dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            // "Authorization": "Bearer $token"
          }
        )
      ).timeout(const Duration(seconds: 15));
      return response;

    } catch (error) {
      if(error is DioException){
        log("$error");
        return error.response;
      }else {
        throw Exception(error);
      }
    }
  }

  // REGISTER
  Future<Response?> registerService(data) async{
    try {
      String url = "$baseUrl$registerRoute";
      log(url);
      var response = await _dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            // "Authorization": "Bearer $token"
          }
        )
      ).timeout(const Duration(seconds: 15));
      return response;

    } catch (error) {
      if(error is DioException){
        log("$error");
        return error.response;
      }else {
        throw Exception(error);
      }
    }
  }

  // VERIFY EMAIL CODE
  Future<Response?> verifyEmailCodeService(email, otp) async{
    try {
      String url = "$baseUrl$verifyEmailRoute$email/$otp";
      log(url);
      var response = await _dio.get(
        url,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            // "Authorization": "Bearer $token"
          }
        )
      );
      return response;

    } catch (error) {
      if(error is DioException){
        log("$error");
        return error.response;
      }else {
        throw Exception(error);
      }
    }
  }

  // RESEND EMAIL VERIFCATION
  Future<Response?> resendEmailVerificationService(data) async{
    try {
      String url = "$baseUrl$resendNotificationRoute";
      var response = await _dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            // "Authorization": "Bearer $token"
          }
        )
      );
      return response;

    } catch (error) {
      if(error is DioException){
        log("$error");
        return error.response;
      }else {
        throw Exception(error);
      }
    }
  }

  // FORGOT PASSWORD
  Future<Response?> forgotPassword(data) async{
    try {
      String url = "$baseUrl$forgotPasswordRoute";
      var response = await _dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            // "Authorization": "Bearer $token"
          }
        )
      );
      return response;

    } catch (error) {
      if(error is DioException){
        log("$error");
        return error.response;
      }else {
        throw Exception(error);
      }
    }
  }

  // RESET PASSWORD
  Future<Response?> resetPassword(data) async{
    try {
      String url = "$baseUrl$resetPasswordRoute";
      var response = await _dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            // "Authorization": "Bearer $token"
          }
        )
      );
      return response;

    } catch (error) {
      if(error is DioException){
        log("$error");
        return error.response;
      }else {
        throw Exception(error);
      }
    }
  }

}