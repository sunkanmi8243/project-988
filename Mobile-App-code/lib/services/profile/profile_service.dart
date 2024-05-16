import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../routes/api/api_routes.dart';
import '../../storage/secureStorage.dart';

class ProfileService {

  final Dio _dio = Dio();

  // GET PROFILE
  Future<Response?> getProfileService() async{
    try {
      String url = "$baseUrl$profileRoute";
      String token = await LocalStorage().fetchUserToken();
      var response = await _dio.get(
        url,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
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

  Future<Response?> updateProfileService(data) async{
    try {
      String url = "$baseUrl$profileRoute";
      String token = await LocalStorage().fetchUserToken();
      var response = await _dio.patch(
        url,
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
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

  Future<Response?> deleteProfileService() async{
    try {
      String url = "$baseUrl$deleteProfileRoute";
      String token = await LocalStorage().fetchUserToken();
      var response = await _dio.delete(
        url,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
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

  Future<Response?> changePasswordService() async{
    try {
      String url = "$baseUrl$profileRoute/password";
      String token = await LocalStorage().fetchUserToken();
      var response = await _dio.patch(
        url,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
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

  Future<Response?> updateProfileImageService(File image) async{
    try {
      String url = "$baseUrl$profilePictureRoute";
      String token = await LocalStorage().fetchUserToken();

      FormData formData = FormData.fromMap({
        'photo': await MultipartFile.fromFile(
          image.path,
        ),
      });

      var response = await _dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
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

  // GET ADDRESSES
  Future<Response?> getAllAddressService() async{
    try {
      String url = "$baseUrl$addressRoutes";
      String token = await LocalStorage().fetchUserToken();
      var response = await _dio.get(
        url,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
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

  // ADD ADDRESSES
  Future<Response?> addAddressService(data) async{
    try {
      String url = "$baseUrl$addressRoutes";
      String token = await LocalStorage().fetchUserToken();
      var response = await _dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
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

  // UPDATE ADDRESSES
  Future<Response?> updateAddressService(data) async{
    try {
      String url = "$baseUrl$addressRoutes";
      String token = await LocalStorage().fetchUserToken();
      var response = await _dio.patch(
        url,
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
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