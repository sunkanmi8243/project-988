import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// import 'package:audioplayers/audioplayers.dart';
// import 'package:aws_polly/aws_polly.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:aws_polly_api/polly-2016-06-10.dart';
import 'package:commerce/model/user_model.dart';
import 'package:commerce/routes/app/app_route_names.dart';
import 'package:commerce/services/cart/cart_services.dart';
import 'package:commerce/services/products/products_services.dart';
import 'package:commerce/services/text-to-speech/tts-service.dart';
import 'package:commerce/storage/secureStorage.dart';
import 'package:commerce/storage/shared_pref.dart';
import 'package:commerce/widgets/Popups/updateProfilePop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../services/order/order_api_services.dart';
import '../services/profile/profile_service.dart';
import '../widgets/bottomsheets/order_success.dart';

class HomeStateController extends GetxController {

  // INSTANT VARIABLES
   List<dynamic> _hotDeals = [

  ];
   List<dynamic> _categories = [

  ];
   List<dynamic> _categoriesList = [

  ];
  List<dynamic> _categoryNames = [

  ];
  List<dynamic> _recognizedImages = [

  ];
  List<String> _models = [
    "main-model",
    "mobilenet-model"
  ];
  String _selectedModel = "";
  Set<String> _uniqueCategoryNames = {};
  List<dynamic> _carts = [];
  String _searchValue = "";
  String _searchValue2 = "";
  RangeValues _selectedRange = const RangeValues(100, 2000);
  UserModel _userModel = UserModel();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  bool _isLoading = false;
  bool _isCartLoading = false;
  bool _isItemLoading = false;
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  DateTime _dateOfBirth = DateTime.now();
  List<dynamic> _isCheckedList = [];
  List<dynamic> _checkedItemsList = [];
  List<dynamic> _ongoingOrders = [];
  List<dynamic> _completedOrders = [];
  List<dynamic> _pendingOrders = [];
  List<dynamic> _orders = [];
  List<dynamic > _completedCardDetails = [];
  List<dynamic > _addresses = [];
  int _currentAddress = 0;
  String _addressName = "";
  String _addressDetails = "";
  String _city = "";
  String _state = "";
  String _addressPhone = "";
  var uuid = Uuid();
  List _itemQuantities = [];
  List<dynamic> _recentSearch = [];
  String _cartKey = "";
  List<dynamic> _filteredProducts = [];
  String _totalSumOfCart = "";
  String _selectedLanguage = "en";
  bool _isVoiceLoading = false;
  bool _notification = true;


  // final AwsPolly _awsPolly = AwsPolly.instance(
  //   poolId: 'us-east-1:78a05867-d08b-4e2b-bbfc-9bf1d447c417',
  //   region: AWSRegionType.USEast1,
  // );
  // String _pollyUrl = "";

  // void onLoadUrl(input) async {
  //   try {
  //     _pollyUrl = "";
  //     final url = await _awsPolly.getUrl(
  //       voiceId: AWSPolyVoiceId.nicole,
  //       input: input,
  //     );
  //     log("URL::::$url");
  //     _pollyUrl = url;
      
  //     onPlay();
  //   } catch (e) {
  //     log(e.toString());
  //     Fluttertoast.showToast(
  //       msg: e.toString(),
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.TOP,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0
  //     );
  //   }

  //   update();
  // }
  // void onPlay() async {
  //   try {
  //     if (_pollyUrl.isEmpty) return;
  //     final player = AudioPlayer();
  //     await player.play(UrlSource(_pollyUrl));
  //   } catch (e) {
  //     log(e.toString());
  //     Fluttertoast.showToast(
  //       msg: e.toString(),
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.TOP,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0
  //     );
  //   }
  // }


  getSpeech(text) async {
    updateIsVoiceLoading(true);
    var service = Polly(
      region: "us-east-1",
      credentials: AwsClientCredentials(
        accessKey: "AKIAT4GLQEY54FVYE5RM", 
        secretKey: "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"
      ),
    );

    var output = await service.synthesizeSpeech(
      outputFormat: OutputFormat.mp3, 
      text: text, 
      voiceId: VoiceId.nicole
    );

    final player = AudioPlayer();
    await player.play(BytesSource(output.audioStream!));

    updateIsVoiceLoading(false);

  }

  // GETTERS
  List get hotDeals => _hotDeals;
  List get categories => _categories;
  List get categoriesList => _categoriesList;
  List get carts => _carts;
  List get models => _models;
  String get selectedModel => _selectedModel;
  List get recognizedImages => _recognizedImages;
  String get searchValue => _searchValue;
  String get searchValue2 => _searchValue2;
  RangeValues get selectedRange  => _selectedRange;
  UserModel get userModel => _userModel;
  TextEditingController get firstname => _firstname;
  TextEditingController get lastname => _lastname;
  TextEditingController get email => _email;
  TextEditingController get phone => _phone;
  TextEditingController get dob => _dob;
  TextEditingController get gender => _gender;
  bool get isLoading => _isLoading;
  bool get isCartLoading => _isCartLoading;
  bool get isItemLoading => _isItemLoading;
  File? get selectedImage => _selectedImage;
  List get isCheckedList => _isCheckedList;
  List get checkedItemList => _checkedItemsList;
  List get orders => _orders;
  List get ongoingOrders => _ongoingOrders;
  List get pendingOrders => _pendingOrders;
  List get completedOrders => _completedOrders;
  List get completedCardDetails => _completedCardDetails;
  List get itemQuantities => _itemQuantities;
  List get addresses => _addresses;
  List<dynamic> get recentSearch => _recentSearch;
  List get categoryNames => _categoryNames;
  Set get uniqueCategoryNames => _uniqueCategoryNames;
  int get currentAddress => _currentAddress;
  String get addressName => _addressName;
  String get addressDetails => _addressDetails;
  String get addressPhone => _addressPhone;
  String get city => _city;
  String get state => _state;
  String get cartKey => _cartKey;
  List get filteredProducts => _filteredProducts;
  String get totalSumOfCart => _totalSumOfCart;
  String get selectedLanguage => _selectedLanguage;
  bool get isVoiceLoading => _isVoiceLoading;
  bool get notification => _notification;


  // SETTERS
  addToCart(value){
    _carts.add(value);
    update();
  }
  removeFromCart(value){
    _carts.remove(value);
    update();
  }
  deleteCart(value){
    _carts.remove(value);
    updateItemQuantities();
    updateSumTotal();
    update();
  }
  updateCartList(value){
    _carts =  value;
    update();
  }
  updateSelectedLanguage(value) async{
    _selectedLanguage = value;
    await LocalStorage().storeLanguage(value);
    update();
  }
  updateIsCheckedList(value){
    _isCheckedList = List.filled(_carts.length, true);
    _checkedItemsList.addAll(value);
    updateItemQuantities();
    updateSumTotal();
    update();
  }
  updateItemList(){
    _checkedItemsList.clear();
    update();
  }
  updateSelectedLanguage1() async{
    _selectedLanguage = await LocalStorage().fetchLanguage();
    update();
  }
  clearItemQuantities(){
    _itemQuantities.clear();
    update();
  }
  addItemList(value){
    _checkedItemsList = value;
    update();
  }
  updateSelectedModel(value){
    _selectedModel = value;
    update();
  }
  toggleCartItemCheck(value, item){
    _isCheckedList[value] = !_isCheckedList[value];
    if(_isCheckedList[value]){
      _checkedItemsList.add(item);
      updateItemQuantities();
      updateSumTotal();
    }else {
      _checkedItemsList.remove(item);
      updateItemQuantities();
      updateSumTotal();
    }
    update();
  }
  updateGender(value){
    _gender.text =  value;
    update();
  }
  updateSearchValue(value){
    _searchValue= value;
    update();
  }
  updateRange(value){
    _selectedRange = value;
    update();
  }
  updateHotDeals(value){
    _hotDeals = value;
    update();
  }
  updateCategories(value){
    _categories = value;
    update();
  }
  updateRecognizedImages(value){
    _recognizedImages = value;
    update();
  }
  updateFilteredProducts() {
    _filteredProducts = _categories;
    update();
  }
  filterProduct(String query) {
    _filteredProducts = _categories
        .where((product) =>
            product["name"].toLowerCase().contains(query.toLowerCase()))
        .toList();

    update();
  }
  updateCategoryNames(value){
    _categoryNames = value;
    _uniqueCategoryNames = Set.from(_categoryNames);
    update();
  }
  updateCategoryTab(value){
    log(value.toString());
    _categoriesList = _categories.where((element) => element["category"]["name"] == value).toList();
    update();
  }
  updateIsLoading(value){
    _isLoading = value;
    update();
  }
  updateIsVoiceLoading(value){
    _isVoiceLoading = value;
    update();
  }
  updateSelectedImage(value){
    _selectedImage = value;
    update();
  }
  updateIsCartLoading(value){
    _isCartLoading = value;
    update();
  }
  updateIsItemLoading(value){
    _isItemLoading = value;
    update();
  }
  updateOrders(value){
    _orders = value;
    update();
  }
  updateAddressList(value){
    _addresses = value;
    update();
  }
  addToAddress(value){
    _addresses.add(value);
    update();
  }
  updateCurrentAddress(value){
    _currentAddress = value;
    update();
  }
  updateAddressName(value){
    _addressName = value;
    update();
  }
  updateAddressDetails(value){
    _addressDetails = value;
    update();
  }
  updateAddressPhone(value){
    _addressPhone = value;
    update();
  }
  updateCity(value){
    _city = value;
    update();
  }
  updateState(value){
    _state = value;
    update();
  }
  updateRecentSearch() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    _recentSearch = StorageService().getSearchedList(pref);
    log(_recentSearch.toString());
    update();
  }
  addToRecentSearch(value) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    _recentSearch.add(value);
    StorageService().storeSearchedList(pref, List<String>.from(_recentSearch));
    update();
  }

  clearRecentSearchList() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    _recentSearch.clear();
    StorageService().clearSearchList(pref);
    update();
  }

  updateCartKey() async{
    String cartStorageKey = await LocalStorage().fetchKey();
    if(cartStorageKey.isEmpty){
      _cartKey = uuid.v4();
      await LocalStorage().storeCartKey(_cartKey);
    }else {
      _cartKey = cartStorageKey;
      null;
    }

    log("CART KEYYYYY:::: $_cartKey");
    log("STORAGE KEYYYYYY:::: $cartStorageKey");

    update();
  }
 
  updateItemQuantities(){
    _itemQuantities = _carts.map((cart) => cart["quantity"]).toList();
    update();
  }

  incrementItem(index){
    _itemQuantities[index] ++;
    update();
  }

  decrement(index){
    _itemQuantities[index] --;
    update();
  }

  void updateSumTotal() {
    if (_checkedItemsList.isEmpty) {
      _totalSumOfCart = "0";
    } else {
      num totalAmount = 0;
      for (int i = 0; i < _checkedItemsList.length; i++) {
        totalAmount += double.parse(_checkedItemsList[i]["price"]) * itemQuantities[i];
      }

      _totalSumOfCart = totalAmount.toString();
    }

    update();
  }
  toggleNotification(){
    _notification = !_notification;
    update();
  }


  // IMAGE PICKER
  Future<void> getImage(ImageSource imageSource) async {
    try {
      var pickedImage = await _imagePicker.pickImage(
        source: imageSource,
      );
      if (pickedImage != null) {
        updateSelectedImage(File(pickedImage.path));

        updateProfilePhoto();

      } else {
        Get.snackbar(
          "Failed",
          "No image selected!",
          colorText: Colors.white,
          backgroundColor: Colors.red
        );
      }
    } on PlatformException catch (e) {
      print(e);
    }

    update();
  }

  // DATE PICKER
  Future<void> showDataePicker (BuildContext context) async{
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth,
      firstDate: DateTime(1950, 01, 01),
      lastDate: DateTime(2024, 01, 01).add(const Duration(days: 365)),
    );
    if (pickedDate != null){
      _dateOfBirth = pickedDate;

      _dob.text = _dateOfBirth.toString().split(" ").first;

    }

    update();
  }

  // API CALLS
  Future getProfile(context) async{
    // updateIsLoading(true);

    var response = await ProfileService().getProfileService();
    var responseData = response!.data;
    log(responseData.toString());

    if(response.statusCode == 200 || response.statusCode == 201){
      // updateIsLoading(false);

      _userModel = UserModel.fromMap(responseData["data"]);
      firstname.text = responseData["data"]["firstname"] ?? "" ;
      email.text = responseData["data"]["email"] ?? "" ;
      lastname.text = responseData["data"]["lastname"] ?? "";
      _phone.text = responseData["data"]["phone"] ?? "";
      _dob.text = responseData["data"]["birthday"]== null? "": responseData["data"]["birthday"].toString().split("T").first;
      _gender.text = responseData["data"]["gender"] ?? "";

      (responseData["data"]["firstname"] == null && responseData["data"]["lastname"] == null)?
      UpdateProfilePopUp.show(context):
      null;


    }else if(responseData["message"] == "Unauthenticated or Token Expired, Please Login"){
      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

      logout();

    } else {
      // updateIsLoading(false);
      
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
  
  Future refreshProfile() async{
    // updateIsLoading(true);

    var response = await ProfileService().getProfileService();
    var responseData = response!.data;
    log(responseData.toString());

    if(response.statusCode == 200 || response.statusCode == 201){
      // updateIsLoading(false);

      _userModel = UserModel.fromMap(responseData["data"]);
      firstname.text = responseData["data"]["firstname"] ?? "" ;
      email.text = responseData["data"]["email"] ?? "" ;
      lastname.text = responseData["data"]["lastname"] ?? "";
      _phone.text = responseData["data"]["phone"] ?? "";
      _dob.text = responseData["data"]["birthday"]== null? "": responseData["data"]["birthday"].toString().split("T").first;
      _gender.text = responseData["data"]["gender"] ?? "";


    }else if(responseData["message"] == "Unauthenticated or Token Expired, Please Login"){
      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

      logout();

    } else {
      // updateIsLoading(false);
      
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
  
  Future deletAccount() async{
    updateIsLoading(true);

    var response = await ProfileService().deleteProfileService();
    var responseData = response!.data;
    log(responseData.toString());

    if(response.statusCode == 200 || response.statusCode == 204){
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

      await LocalStorage().deleteUserStorage();

       }else if(responseData["message"] == "Unauthenticated or Token Expired, Please Login"){
      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

      logout();

    } else {
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
  
  Future updateProfile(context) async {
    updateIsLoading(true);

    var data = {
      "firstname": _firstname.text,
      "lastname": _lastname.text,
      "gender": _gender.text,
      "birthday": _dob.text,
      "phone": _phone.text,
    };

    var response = await ProfileService().updateProfileService(data);
    var responseData = response!.data;
    log(responseData.toString());

    if(response.statusCode == 200){
      updateIsLoading(false);
      
      _userModel = UserModel.fromMap(responseData["data"]);
      firstname.text = responseData["data"]["firstname"] ?? "" ;
      email.text = responseData["data"]["email"] ?? "" ;
      lastname.text = responseData["data"]["lastname"] ?? "";
      _phone.text = responseData["data"]["phone"] ?? "";
      getProfile(context);

      Fluttertoast.showToast(
        msg: responseData["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

       }else if(responseData["message"] == "Unauthenticated or Token Expired, Please Login"){
      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

      logout();

    } else {
      updateIsLoading(false);

      Fluttertoast.showToast(
        msg: responseData["message"],
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
  
  Future updateProfilePhoto() async {
    updateIsLoading(true);

    var response = await ProfileService().updateProfileImageService(_selectedImage!);
    var responseData = response!.data;

    if(response.statusCode == 200){
      updateIsLoading(false);

      Fluttertoast.showToast(
        msg: responseData["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

       }else if(responseData["message"] == "Unauthenticated or Token Expired, Please Login"){
      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

      logout();

    } else {
      updateIsLoading(false);

      Fluttertoast.showToast(
        msg: responseData["message"],
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
  
  Future getProducts() async {
    updateIsLoading(true);

    var response = await ProductsServices().getProductsServices();
    var responseData = response!.data;
    log(responseData.toString());

    if(response.statusCode == 200){
      updateIsLoading(false);

      updateHotDeals(responseData["data"]);
      updateCategories(responseData["data"]);
      updateCategoryNames(
        _categories.map((category) => category["category"]["name"]).toList()
      );
      updateCategoryTab(_uniqueCategoryNames.first);

       }else if(responseData["message"] == "Unauthenticated or Token Expired, Please Login"){
      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

      logout();

    } else {
      updateIsLoading(false);

      Fluttertoast.showToast(
        msg: responseData["message"],
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

  Future logout() async{
    await LocalStorage().deleteToken();
    Get.offAllNamed(loginScreen);
    update();
  }

  Future addCart(id, details) async{
    updateIsCartLoading(true);

    var data = {
      "product": id,
      "key": _cartKey
    };

    var response = await CartServices().addToCartService(data);
    var responseData = response!.data;
    log(responseData.toString());

    if(response.statusCode == 200){
      updateIsCartLoading(false);

      addToCart(details);

      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

       }else if(responseData["message"] == "Unauthenticated or Token Expired, Please Login"){
      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

      logout();

    } else {
      updateIsCartLoading(false);


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

  Future addItem(id, index) async{
    updateIsLoading(true);

    incrementItem(index);

    var data = {
      "product": id,
      "key": _cartKey,
      "quantity": _itemQuantities[index]
    };

    var response = await CartServices().addToCartService(data);
    var responseData = response!.data;
    log(responseData.toString());

    if(response.statusCode == 200){
      updateIsLoading(false);

      // getCarts2();
      updateSumTotal();

      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

       }else if(responseData["message"] == "Unauthenticated or Token Expired, Please Login"){
      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

      logout();

    } else {
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

  Future decrementItem(id, index) async{
    updateIsLoading(true);

    decrement(index);

    var data = {
      "product": id,
      "key": _cartKey,
      "quantity": _itemQuantities[index]
    };

    var response = await CartServices().addToCartService(data);
    var responseData = response!.data;
    log(responseData.toString());

    if(response.statusCode == 200){
      updateIsLoading(false);

      updateSumTotal();

      // getCarts2();

      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

       }else if(responseData["message"] == "Unauthenticated or Token Expired, Please Login"){
      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

      logout();

    } else {
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

  Future buyNow(id, details) async{
    updateIsCartLoading(true);

    var data = {
      "product": id,
      "key": _cartKey
    };

    var response = await CartServices().addToCartService(data);
    var responseData = response!.data;
    log(responseData.toString());

    if(response.statusCode == 200){
      updateIsCartLoading(false);

      addToCart(details);

      checkoutCart(
        responseData["data"]["key"], 
        details, 
        id
      );

       }else if(responseData["message"] == "Unauthenticated or Token Expired, Please Login"){
      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

      logout();

    } else {
      updateIsCartLoading(false);


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

  Future deleteFromCart(id, details, key) async{
    updateIsCartLoading(true);

    var data = {
      "key": key
    };

    var response = await CartServices().deleteFromCartService(id, data);
    var responseData = response!.data;
    log(responseData.toString());

    if(response.statusCode == 200 || response.statusCode == 204){
      updateIsCartLoading(false);

      _checkedItemsList.remove(details);
      deleteCart(details);

      Fluttertoast.showToast(
        msg: "Item removed successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

       }else if(responseData["message"] == "Unauthenticated or Token Expired, Please Login"){
      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

      logout();

    } else {
      updateIsCartLoading(false);

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

  Future updateCartDetails(id, index) async{
    updateIsLoading(true);

    incrementItem(index);

    var data = {
      "key": _cartKey,
      "quantity": _itemQuantities[index]
    };

    var response = await CartServices().updateCartService(id, data);
    var responseData = response!.data;
    log(responseData.toString());

    if(response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204){
      updateIsLoading(false);

      getCarts2();

      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

       }else if(responseData["message"] == "Unauthenticated or Token Expired, Please Login"){
      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

      logout();

    } else {
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

  Future getCarts() async{
    updateIsItemLoading(true);

    var response = await CartServices().getCartsService(_cartKey);
    var responseData = response!.data;
    log(responseData.toString());

    if(response.statusCode == 200){
      updateIsItemLoading(false);
      
      updateCartList(responseData["data"]);
      // addItemList(responseData["data"]);

      if(_carts.isEmpty){
        null;
      }else {
        _cartKey = "";
      }

       }else if(responseData["message"] == "Unauthenticated or Token Expired, Please Login"){
      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

      logout();

    } else {
      updateIsItemLoading(false);

      // Fluttertoast.showToast(
      //   msg: response.data["message"].toString(),
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.TOP,
      //   timeInSecForIosWeb: 1,
      //   backgroundColor: Colors.red,
      //   textColor: Colors.white,
      //   fontSize: 16.0
      // );
    }

    update();
  }

  Future getCarts2() async{
    updateIsItemLoading(true);

    var response = await CartServices().getCartsService(_cartKey);
    var responseData = response!.data;
    log(responseData.toString());

    if(response.statusCode == 200){
    updateIsItemLoading(false);
      
      updateCartList(responseData["data"]);
      updateIsCheckedList(responseData["data"]);

       }else if(responseData["message"] == "Unauthenticated or Token Expired, Please Login"){
      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

      logout();

    } else {
    updateIsItemLoading(false);

      // Fluttertoast.showToast(
      //   msg: response.data["message"].toString(),
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.TOP,
      //   timeInSecForIosWeb: 1,
      //   backgroundColor: Colors.red,
      //   textColor: Colors.white,
      //   fontSize: 16.0
      // );
    }

    update();
  }

  // CHECKOUT
  Future checkoutCart(key, details, id) async{
    updateIsCartLoading(true);

    var data = {
      "address_id": id
    };

    log(data.toString());
    log(key.toString());
    log(details.toString());

    var response = await CartServices().checkoutService(key, data);
    var responseData = response!.data;
    log(responseData.toString());

    if(response.statusCode == 200){
      updateIsCartLoading(false);

      removeFromCart(details);
      OrderSuccess.show();

       }else if(responseData["message"] == "Unauthenticated or Token Expired, Please Login"){
      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

      logout();

    } else {
      updateIsCartLoading(false);

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

  // GET ALL ORDERS
  Future getOrders() async{
    updateIsLoading(true);

    var response = await OrderServices().getAllOrders();
    var responseData = response!.data;
    log(responseData.toString());

    if(response.statusCode == 200){
      updateIsLoading(false);

      updateOrders(responseData["data"]);
      _pendingOrders = _orders.where((order) => order["status"] == "Pending").toList();
      _completedOrders = _orders.where((order) => order["status"] == "Paid").toList();
      
       }else if(responseData["message"] == "Unauthenticated or Token Expired, Please Login"){
      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

      logout();

    } else {
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

  // PAY FOR ORDER
  Future payForOrder(id) async{
    updateIsItemLoading(true);

    var response = await OrderServices().payForOrder(id);
    var responseData = response!.data;
    log(responseData.toString());

    if(response.statusCode == 200){
      updateIsItemLoading(false);

      _pendingOrders = _orders.where((order) => order["status"] == "Pending").toList();
      _completedOrders = _orders.where((order) => order["status"] == "Paid").toList();

      getOrders();

      OrderSuccess.show();
      
       }else if(responseData["message"] == "Unauthenticated or Token Expired, Please Login"){
      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

      logout();

    } else {
      updateIsItemLoading(false);

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

  // GET ORDER DETAILS
  Future getOrderDetails(id) async{
    // updateIsItemLoading(true);

    var response = await OrderServices().getSingleOrder(id);
    var responseData = response!.data;
    log(responseData.toString());

    if(response.statusCode == 200){
      // updateIsItemLoading(false);



       }else if(responseData["message"] == "Unauthenticated or Token Expired, Please Login"){
      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

      logout();

    } else {
      // updateIsItemLoading(false);

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
  
  // GET ADDRESSES
  Future getAllAddress() async{
    updateIsLoading(true);

    var response = await ProfileService().getAllAddressService();
    var responseData = response!.data;
    log(responseData.toString());

    if(response.statusCode == 200){
      updateIsLoading(false);

      updateAddressList(responseData["data"]);

       }else if(responseData["message"] == "Unauthenticated or Token Expired, Please Login"){
      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

      logout();

    } else {
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
  
  // ADD ADDRESSES
  Future addAddress() async{
    updateIsLoading(true);

    var data = {
      "name": _addressName,
      "email": _userModel.email,
      "phone": _addressPhone,
      "street": _addressDetails,
      "city": _city,
      "state": _state,
      "country": "NG"
    };

    var response = await ProfileService().addAddressService(data);
    var responseData = response!.data;
    log(responseData.toString());

    if(response.statusCode == 200 || response.statusCode == 201){
      updateIsLoading(false);

      Get.back();
      getAllAddress();

       }else if(responseData["message"] == "Unauthenticated or Token Expired, Please Login"){
      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

      logout();

    } else {
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

  // SEARCH IMAGE
  Future searchImage(File image) async{
     updateIsLoading(true);

     var response = await ProductsServices().searchImageService(image);
     var responseData = response!.data;
     log(responseData.toString());

     if(response.statusCode == 200 || response.statusCode == 201){
       updateIsLoading(false);

       _searchValue2 = "Scanned";
       updateRecognizedImages(responseData["data"]);

       Get.toNamed(
        searchedProductScreen2,
        arguments: responseData["data"]
      );

        }else if(responseData["message"] == "Unauthenticated or Token Expired, Please Login"){
      Fluttertoast.showToast(
        msg: response.data["message"].toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

      logout();

    } else {
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

  // TRIGGER VOICE
  Future triggerVoice(code, text) async{
     updateIsVoiceLoading(true);

     var data = {
      "Engine": "standard",
      "LanguageCode": code,
      "OutputFormat": "mp3",
      "SpeechMarkTypes": [ "sentence", "word" ],
      "Text": text,
      "TextType": "text",
      "VoiceId": (code == "en-US")?
      "Camila":
      (code == "ja-JP")?
      "Kazuha":
      (code == "Id-ID")?
      "Kazuha":
      (code == "yue-CN")?
      "Zhiyu":
      "Camila"
    };

     var response = await TTSService().triggerVoiceService(data);
     var responseData = response!.data;
     log(responseData.toString());

     if(response.statusCode == 200 || response.statusCode == 201){
       updateIsVoiceLoading(false);

    } else {
       updateIsVoiceLoading(false);

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