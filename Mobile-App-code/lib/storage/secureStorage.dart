import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage{

  final FlutterSecureStorage _flutterSecureStorage = const FlutterSecureStorage();

  // STORE 
  storeCartKey(String key) async{
    try {
      await _flutterSecureStorage.write(key: "Key", value: key);
      log("Saved Key");
    } catch (e) {
      log(e.toString());
      log("Could not save key");
    }
  }

  // FETCH ID
  Future<String> fetchKey() async{
    String key = await _flutterSecureStorage.read(key: "Key") ?? "";
    log("Fetched key successful");

    return key;
  }

  // STORE TOKEN
  storeUserToken(String token) async{
    try {
      await _flutterSecureStorage.write(key: "Token", value: token);
      log("Saved Token");
    } catch (e) {
      log(e.toString());
      log("Could not save token");
    }
  }

  // FETCH TOKEN
  Future<String> fetchUserToken() async{
    String token = await _flutterSecureStorage.read(key: "Token") ?? "";
    log("Fetched token successful");

    return token;
  }

  // STORE FCM TOKEN
  storeFCMToken(String token) async{
    try {
      await _flutterSecureStorage.write(key: "FCMTOKEN", value: token);
      log("Saved Token");
    } catch (e) {
      log(e.toString());
      log("Could not save token");
    }
  }

  // FETCH TOKEN
  Future<String> fetchFCMToken() async{
    String token = await _flutterSecureStorage.read(key: "FCMTOKEN") ?? "";
    log("Fetched token successful");

    return token;
  }

  // STORE DEVICE ID
  storeDeviceId(String deviceID) async{
    try {
      await _flutterSecureStorage.write(key: "DeviceID", value: deviceID);
      log("Saved Id");
    } catch (e) {
      log(e.toString());
      log("Could not save id");
    }
  }

  // FETCH DEVICE ID
  Future<String> fetchDeviceID() async{
    String deviceID = await _flutterSecureStorage.read(key: "DeviceID") ?? "";
    log("Fetched Id successful");

    return deviceID;
  }

  // STORE EMAIL
  storeEmail(String email) async{
    try {
      await _flutterSecureStorage.write(key: "Email", value: email);
      log("Saved Email");
    } catch (e) {
      log(e.toString());
      log("Could not save EMail");
    }
  }

  // FETCH EMAIL
  Future<String> fetchEmail() async{
    String email = await _flutterSecureStorage.read(key: "Email") ?? "";
    log("Fetched email successful");

    return email;
  }

  // STORE LANGUAGE
  storeLanguage(String language) async{
    try {
      await _flutterSecureStorage.write(key: "Language", value: language);
      log("Saved Language");
    } catch (e) {
      log(e.toString());
      log("Could not save Language");
    }
  }

  // FETCH LANGUAGE
  Future<String> fetchLanguage() async{
    String language = await _flutterSecureStorage.read(key: "Language") ?? "";
    log("Fetched Language successful");

    return language;
  }

  // STORE LOCATION
  storeLocation(String location) async{
    try {
      await _flutterSecureStorage.write(key: "LOCATION", value: location);
      log("Saved LOCATION");
    } catch (e) {
      log(e.toString());
      log("Could not save EMail");
    }
  }

  // FETCH LOCATION
  Future<String> fetchLocation() async{
    String location = await _flutterSecureStorage.read(key: "LOCATION") ?? "";
    log("Fetched LOCATION successful");

    return location;
  }

  // STORE DEVICE NAME
  storeDeviceName(String name) async{
    try {
      await _flutterSecureStorage.write(key: "DEVICENAME", value: name);
      log("Saved name");
    } catch (e) {
      log(e.toString());
      log("Could not save EMail");
    }
  }

  // FETCH DEVICE NAME
  Future<String> fetchDevcieName() async{
    String name = await _flutterSecureStorage.read(key: "DEVICENAME") ?? "";
    log("Fetched NAME successful");

    return name;
  }

  // STORE USER ROLE
  storeUserRole(String role) async{
    try {
      await _flutterSecureStorage.write(key: "ROLE", value: role);
      log("Saved role");
    } catch (e) {
      log(e.toString());
      log("Could not role EMail");
    }
  }

  // FETCH DEVICE NAME
  Future<String> fetchRole() async{
    String role = await _flutterSecureStorage.read(key: "ROLE") ?? "";
    log("Fetched ROLE successful");

    return role;
  }

  // DELETE USER FROM STORAGE
  Future<void> deleteUserStorage() async{
    await _flutterSecureStorage.deleteAll();
    log("Deleted Storage :)");
  }

  // DELETE USER FROM STORAGE
  Future<void> deleteToken() async{
    await _flutterSecureStorage.delete(key: "Token");
    log("Deleted Storage :)");
  }
}