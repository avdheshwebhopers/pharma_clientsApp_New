import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pharma_clients_app/data/model/response_model/faqsResponseModel.dart';
import 'package:pharma_clients_app/data/model/response_model/products/product_reponse_model.dart';
import 'package:pharma_clients_app/resources/constant_strings.dart';
import 'package:pharma_clients_app/utils/utils.dart';
import 'package:pharma_clients_app/views/forgotPassword/ResetPasswordScreen.dart';
import 'package:pharma_clients_app/views/forgotPassword/verifyOtpScreen.dart';
import 'package:pharma_clients_app/views/login_screen.dart';
import '../../data/model/response_model/about_company/about_company_response_model.dart';
import '../../data/model/response_model/about_company/about_promotional_screen.dart';
import '../../data/model/response_model/count/guestDbcount_responseModel.dart';
import '../../data/model/response_model/products/packing_type_response_model.dart';
import '../../data/model/response_model/visual_aids_response_model.dart';
import '../../data/repository/Beforelogin/beforeLogin_repository.dart';
import '../../data/response/api_response.dart';

class GuestProductViewModel with ChangeNotifier{


  List<Products> product = [];
  List<Products> _filteredProducts = [];

  List<Products> get products => _filteredProducts;

  final _myRepo = BeforeLoginRepository();

  ApiResponse<ProductResponseModel> productlist = ApiResponse.loading();

  setProductList(ApiResponse<ProductResponseModel> response){
    productlist = response;
    notifyListeners();
  }

  Future<void> fetchProductApi() async {

    setProductList(ApiResponse.loading());

    _myRepo.fetchProductList().then((value){

      for (var element in value.data!) {
        if(element.active == true){
          product.add(element);
        }
      }
      _filteredProducts = product;
      notifyListeners();

      setProductList(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      setProductList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  void filterItems(String searchQuery){
    _filteredProducts = product.where((element) {
      return element.name!.toLowerCase().contains(searchQuery)
          || element.typeName!.toLowerCase().contains(searchQuery)
        || element.categoryName!.toLowerCase().contains(searchQuery)||
          element.description!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    notifyListeners();
  }
}

class GuestVisualAidsViewModel with ChangeNotifier{

  final _myRepo = BeforeLoginRepository();

  ApiResponse<VisualAidsResponseModel> visualaidsList = ApiResponse.loading();

  setAboutCompanyList(ApiResponse<VisualAidsResponseModel> response){
    visualaidsList = response;
    notifyListeners();
  }

  Future<void> fetchVisualAids() async {

    setAboutCompanyList(ApiResponse.loading());

    _myRepo.fetchVisualAids().then((value){

      setAboutCompanyList(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      setAboutCompanyList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

}

class RegisterViewModel with ChangeNotifier{

  final _myRepo = BeforeLoginRepository();

  bool _loading = false ;
  bool get loading => _loading ;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> register(
      dynamic data,
      BuildContext context,
      TextEditingController name,
      TextEditingController email,
      TextEditingController phone,
      TextEditingController address,
      String state,
      String city,
      TextEditingController dob,
      TextEditingController operationArea,
      TextEditingController password,
      TextEditingController confirmPassword,
      TextEditingController firmName,
      TextEditingController gstNumber,
      TextEditingController drugLicense,
      TextEditingController aadharNumber,
      TextEditingController firmPhone,
      TextEditingController firmEmail,
      TextEditingController firmAddress,
      String firmState,
      String firmCity,
      TextEditingController bankName,
      TextEditingController ifscCode,
      TextEditingController accountNumber,
      TextEditingController payeeName,

      ) async {

    setLoading(true);

    _myRepo.register(data).then((value){

      setLoading(false);

      if(value.success == true){

        name.clear();
        email.clear();
        phone.clear();
        address.clear();
        state = 'NA';
        city ='NA';
        dob.clear();
        operationArea.clear();
        password.clear();
        confirmPassword.clear();
        firmName.clear();
        gstNumber.clear();
        drugLicense.clear();
        aadharNumber.clear();
        firmPhone.clear();
        firmAddress.clear();
        firmState = 'NA';
        firmCity ='NA';
        firmEmail.clear();
        bankName.clear();
        ifscCode.clear();
        accountNumber.clear();
        payeeName.clear();

        Utils.successAlertDialogue("Contact tour administrator to activate", (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context)=> const LoginScreen()));
          },context);

      }else{
        Utils.errorAlertDialogue(value.message.toString(), context);
      }

    }).onError((error, stackTrace){

      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

class GuestDbCountViewModel with ChangeNotifier{

  final _myRepo = BeforeLoginRepository();

  DbCount? data;
  DbCount? get dataa => data;

  bool _loading = false ;
  bool get loading => _loading ;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void>fetchDbCountApi() async {
    setLoading(true);
    _myRepo.fetchDbCount().then((value){
      data = value.data;
      notifyListeners();
      setLoading(false);
    }).onError((error, stackTrace){
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

class PackingViewModel with ChangeNotifier{

  final _myRepo = BeforeLoginRepository();

  ApiResponse<PackingTypeResponseModel> packingtypelist = ApiResponse.loading();

  setPackingList(ApiResponse<PackingTypeResponseModel> response){
    packingtypelist = response;
    notifyListeners();
  }

  Future<void> fetchPackingTypeApi() async {

    setPackingList(ApiResponse.loading());

    _myRepo.fetchPackingType().then((value){

      setPackingList(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      setPackingList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }

    });
  }
}

class AboutCompanyViewModel with ChangeNotifier{

  final _myRepo = BeforeLoginRepository();

  ApiResponse<AboutCompanyResponseModel> aboutCompany = ApiResponse.loading();

  setAboutCompanyList(ApiResponse<AboutCompanyResponseModel> response){
    aboutCompany = response;
    notifyListeners();
  }

  Future<void> fetchAboutCompany() async {
    setAboutCompanyList(ApiResponse.loading());
    _myRepo.fetchAboutCompany().then((value){

      setAboutCompanyList(ApiResponse.completed(value));

    }).onError((error, stackTrace){
      setAboutCompanyList(ApiResponse.error(error.toString()));

    });
  }

}

class AboutPromotionalViewModel with ChangeNotifier{

  final _myRepo = BeforeLoginRepository();

  ApiResponse<PromotionalResponseModel> promotional = ApiResponse.loading();

  setAboutCompanyList(ApiResponse<PromotionalResponseModel> response){
    promotional = response;
    notifyListeners();
  }

  Future<void> fetchPromotional() async {

    setAboutCompanyList(ApiResponse.loading());

    _myRepo.fetchPromotional().then((value){

      setAboutCompanyList(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      setAboutCompanyList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }

    });
  }

}

class ProfileSearchViewModel with ChangeNotifier{

  bool _loading = false ;
  bool get loading => _loading;

  bool _success = false ;
  bool get success => _success;

  final _myRepo = BeforeLoginRepository();

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> getProfile(data, BuildContext context) async {

    setLoading(true);
    _myRepo.getprofile(data).then((value){
      setLoading(false);
      if(value.success == true){
        Utils.flushBarSuccessMessage(ConstantStrings.otpSent, context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpScreen(
                    id: value.data!.id!,
                    email: value.data!.email!
                )));
      }else{
        Utils.errorAlertDialogue(value.message, context);
      }

    }).onError((error, stackTrace){
      
      setLoading(false);
      
      if (kDebugMode) {
        print(error.toString());
      }

    });
  }

  Future<void> resendOtp(data, BuildContext context) async {

    setLoading(true);
    _myRepo.getprofile(data).then((value){
      setLoading(false);
      if(value.success == true){
        Utils.flushBarSuccessMessage(ConstantStrings.otpSent, context);
      }else{
        Utils.errorAlertDialogue(value.message, context);
      }
    }).onError((error, stackTrace){
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

}

class OtpVerifyViewModel with ChangeNotifier{

  bool _loading = false ;
  bool get loading => _loading;

  final _myRepo = BeforeLoginRepository();

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> verifyOtp(data, BuildContext context) async {

    setLoading(true);

    _myRepo.verifyOtp(data).then((value){
      setLoading(false);
      if(value.success == true){

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResetPasswordScreen(
                    id: value.data!.id!,
                )));

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => OtpScreen(
        //             id: value.data!.id!,
        //             email: value.data!.email!
        //         )));
      }else{
        Utils.errorAlertDialogue(value.message, context);
      }

    }).onError((error, stackTrace){

      setLoading(false);

      if (kDebugMode) {
        print(error.toString());
      }

    });
  }

}

class ResetPasswordViewModel with ChangeNotifier{

  bool _loading = false ;
  bool get loading => _loading;

  final _myRepo = BeforeLoginRepository();

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> resetPassword(data, BuildContext context ,

      TextEditingController newPassword,
      TextEditingController confirmPassword,

      ) async {

    setLoading(true);

    _myRepo.resetPassword(data).then((value){
      setLoading(false);
      if(value.success == true){

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const LoginScreen()));

        newPassword.clear();
        confirmPassword.clear();

      }else{
        Utils.errorAlertDialogue(value.message, context);
      }

    }).onError((error, stackTrace){

      setLoading(false);

      if (kDebugMode) {
        print(error.toString());
      }

    });
  }

}

class FAQsViewModel with ChangeNotifier{

  final _myRepo = BeforeLoginRepository();

  ApiResponse<FAQsResponseModel> faqs = ApiResponse.loading();

  setFAQsList(ApiResponse<FAQsResponseModel> response){
    faqs = response;
    notifyListeners();
  }

  Future<void> fetchFAQs() async {
    setFAQsList(ApiResponse.loading());
    _myRepo.getFAQs().then((value){

      setFAQsList(ApiResponse.completed(value));

    }).onError((error, stackTrace){
      setFAQsList(ApiResponse.error(error.toString()));

    });
  }

}