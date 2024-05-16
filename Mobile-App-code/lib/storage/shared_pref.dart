import 'package:shared_preferences/shared_preferences.dart';

class StorageService {

  // STORE SEARCHED LIST
  storeSearchedList(SharedPreferences preferences, List<String> data) async{
    await preferences.setStringList('searchedList', data);
  }

  // GET SEARCHED LIST
  List<String> getSearchedList(SharedPreferences preferences) {
    List<String>? items = preferences.getStringList('searchedList');
    return items!;
  }

  // DELETE SEARCHED LIST
  clearSearchList(SharedPreferences preferences) {
    preferences.remove("searchedList");
  }

}