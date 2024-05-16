import 'dart:developer';

import 'package:dio/dio.dart';

class TTSService {

  final Dio _dio = Dio();

  Future<Response?> triggerVoiceService(data) async{
    try {
      String url = "https://polly.ap-southeast-2.amazonaws.com/v1/speech";

      var response = await _dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authentication": "XpGMRaEgWr+HZJ4qxQ1ipd8r4YfH/TWt6XePHK+v"
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