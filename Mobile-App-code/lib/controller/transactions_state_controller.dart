import 'dart:developer';

import 'package:commerce/services/transaction/transaction_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class TransactionStateController extends GetxController {

  // instant variables
  List<dynamic> _transactions = [];
  bool _isLoading = false;

  // getters
  List get transactions => _transactions;
  bool get isLoading => _isLoading;

  // setters
  updateIsLoading(value){
    _isLoading = value;
    update();
  }
  updateTransactions(value){
    _transactions = value;
    update();
  }

  // api calls
  Future getTransactions() async{
    updateIsLoading(true);

    var response = await TransactionServices().getTransactionsService();
    var responseData = response!.data;
    log(responseData.toString());

    if(response.statusCode == 200){
      updateIsLoading(false);

      updateTransactions(responseData["data"]);
      
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

    update();
  }

  Future verifyTransactions(id) async{
    updateIsLoading(true);

    var data = {
      "reference": "7867jkbkjgqdw7qydkh3i87duhkjlihqae",
      "provider": "PAYSTACK"
    };

    var response = await TransactionServices().verifyTransactionService(id, data);
    var responseData = response!.data;
    log(responseData.toString());

    if(response.statusCode == 200){
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

    update();
  }

}