import 'dart:developer';

import 'package:commerce/routes/api/api_routes.dart';
import 'package:dio/dio.dart';

import '../../storage/secureStorage.dart';

class TransactionServices {

   final Dio _dio = Dio();

  Future<Response?> getTransactionsService() async {
    try {
      String url = "$baseUrl$transactionRoutes";
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

  Future<Response?> getSingleTransactionService(id) async {
    try {
      String url = "$baseUrl$transactionRoutes/$id";
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

  Future<Response?> verifyTransactionService(id, data) async {
    try {
      String url = "$baseUrl$transactionRoutes/verify/$id";
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