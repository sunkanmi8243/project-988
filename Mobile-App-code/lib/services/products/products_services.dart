import 'dart:developer';
import 'dart:io';

import 'package:commerce/routes/api/api_routes.dart';
import 'package:dio/dio.dart';

import '../../storage/secureStorage.dart';

class ProductsServices {

   final Dio _dio = Dio();

  Future<Response?> getProductsServices() async {
    try {
      String url = "$baseUrl$productsRoutes";
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

  Future<Response?> getSingleProductService(id) async {
    try {
      String url = "$baseUrl$productsRoutes/$id";
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

  Future<Response?> searchImageService(File? image) async {
     try {
       String url = "$baseUrl$searchImageRoute";
       String token = await LocalStorage().fetchUserToken();

       FormData formData = FormData.fromMap({
         'image': await MultipartFile.fromFile(image!.path)
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