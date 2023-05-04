import 'dart:async';
import 'package:pharma_clients_app/data/model/response_model/faqsResponseModel.dart';
import 'package:pharma_clients_app/data/model/response_model/forgotPassword/otpVerificationResponseModel.dart';
import 'package:pharma_clients_app/data/model/response_model/forgotPassword/profileSearchResponseModel.dart';
import 'package:pharma_clients_app/data/model/response_model/forgotPassword/resetPasswordResponseModel.dart';
import 'package:pharma_clients_app/data/model/response_model/register_responsemodel.dart';
import '../../../resources/app_urls.dart';
import '../../model/response_model/about_company/about_company_response_model.dart';
import '../../model/response_model/about_company/about_promotional_screen.dart';
import '../../model/response_model/count/guestDbcount_responseModel.dart';
import '../../model/response_model/products/packing_type_response_model.dart';
import '../../model/response_model/products/product_reponse_model.dart';
import '../../model/response_model/visual_aids_response_model.dart';
import '../../network/base_api_services.dart';
import '../../network/network_api_services.dart';

class BeforeLoginRepository{

  BaseApiServices apiServices = NetworkApiServices();

  Future<ProductResponseModel> fetchProductList() async {
    try{
      dynamic response =  await apiServices.postEmptyParmApiResponse(AppUrls.productApi, '');
      return response = ProductResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<PackingTypeResponseModel> fetchPackingType()async{

    try{
      dynamic response  = await apiServices.postEmptyParmApiResponse(AppUrls.packingType, '');
      return response = PackingTypeResponseModel.fromJson(response);

    }catch(e){
      rethrow;
    }
  }

  Future<VisualAidsResponseModel> fetchVisualAids() async {

    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.visualAidsApi, null);
      return response = VisualAidsResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<GuestDbCountResponseModel> fetchDbCount() async {

    try{
      dynamic response =  await apiServices.getApiResponse(AppUrls.homeCountApi);
      return response = GuestDbCountResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<PromotionalResponseModel> fetchPromotional() async {

    try{
      dynamic response =  await apiServices.getApiResponse(AppUrls.getPromotional);
      return response = PromotionalResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<AboutCompanyResponseModel> fetchAboutCompany() async {

    try{
      dynamic response =  await apiServices.getApiResponse(AppUrls.getAbout);
      return response = AboutCompanyResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<RegisterResponseModel> registerFields(dynamic data) async {

    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.registerFields, data);
      return response = RegisterResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<RegisterResponseModel> register(dynamic data) async {

    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.register, data);
      return response = RegisterResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<ProfileSearchResponseModel> getprofile(dynamic data) async {

    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.forgotPassword, data);
      return response = ProfileSearchResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<OtpVerificationResponseModel> verifyOtp(dynamic data) async {

    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.validate_otp, data);
      return response = OtpVerificationResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<ResetPasswordResponseModel> resetPassword(dynamic data) async {

    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.resetAccount, data);
      return response = ResetPasswordResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<FAQsResponseModel> getFAQs() async {

    try{
      dynamic response =  await apiServices.getApiResponse(AppUrls.faqs);
      return response = FAQsResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

}