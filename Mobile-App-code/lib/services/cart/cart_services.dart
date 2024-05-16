import 'dart:developer';

import 'package:dio/dio.dart';

import '../../routes/api/api_routes.dart';
import '../../storage/secureStorage.dart';

class CartServices {

   final Dio _dio = Dio();

   Future<Response?> getCartsService(key) async {
    try {
      String url = "$baseUrl$cartsRoute";
      String token = await LocalStorage().fetchUserToken();
      var response = await _dio.get(
        url,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          }
        ),
        queryParameters: {
          "key": key
        }
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

   Future<Response?> addToCartService(data) async {
    try {
      String url = "$baseUrl$cartsRoute";
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
        ),
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

   Future<Response?> deleteFromCartService(id, data) async {
    try {
      String url = "$baseUrl$cartsRoute/$id";
      log(url);
      String token = await LocalStorage().fetchUserToken();
      var response = await _dio.delete(
        url,
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          }
        ),
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

   Future<Response?> updateCartService(id, data) async {
    try {
      String url = "$baseUrl$cartsRoute/$id";
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
        ),
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

   Future<Response?> checkoutService(key, data) async {
    try {
      String url = "$baseUrl$cartsRoute/checkout/$key";
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
        ),
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