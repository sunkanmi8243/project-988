import 'dart:developer';

import 'package:commerce/routes/api/api_routes.dart';
import 'package:dio/dio.dart';

import '../../storage/secureStorage.dart';

class OrderServices {

   final Dio _dio = Dio();

  Future<Response?> getAllOrders() async {
    try {
      String url = "$baseUrl$orderRoutes";
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

  Future<Response?> getSingleOrder(id) async {
    try {
      String url = "$baseUrl$orderRoutes/$id";
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

  Future<Response?> payForOrder(id) async {
    try {
      String url = "$baseUrl$orderRoutes/$id/pay";
      String token = await LocalStorage().fetchUserToken();
      var response = await _dio.post(
        url,
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