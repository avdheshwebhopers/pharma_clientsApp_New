import 'package:pharma_clients_app/data/model/response_model/CitiesResponseModel.dart';
import 'package:pharma_clients_app/data/model/response_model/Orders/customersOrder_responseModel.dart';
import 'package:pharma_clients_app/data/model/response_model/PlaceOrder/placeCustomerOrderResponseModel.dart';
import 'package:pharma_clients_app/data/model/response_model/PlaceOrder/placeOrderResponseModel.dart';
import 'package:pharma_clients_app/data/model/response_model/customers/UpdateCustomerResponseModel.dart';
import 'package:pharma_clients_app/data/model/response_model/customers/addCustomer_responseModel.dart';
import 'package:pharma_clients_app/data/model/response_model/change_passwordResponseModel.dart';
import 'package:pharma_clients_app/data/model/response_model/Orders/companyOrder_responseModel.dart';
import 'package:pharma_clients_app/data/model/response_model/count/db_count_responsemodel.dart';
import 'package:pharma_clients_app/data/model/response_model/customers/customers_responseModel.dart';
import 'package:pharma_clients_app/data/model/response_model/division_responseModel.dart';
import 'package:pharma_clients_app/data/model/response_model/favouriteProducts/favouriteResponseModel.dart';
import 'package:pharma_clients_app/data/model/response_model/firmResponseModel.dart';
import 'package:pharma_clients_app/data/model/response_model/mrs/mrsUpdateResponseModel.dart';
import 'package:pharma_clients_app/data/model/response_model/mrs/mrs_responseModel.dart';
import 'package:pharma_clients_app/data/model/response_model/offers_reposnseModel.dart';
import 'package:pharma_clients_app/data/model/response_model/mrs/statusMrResponseModel.dart';
import 'package:pharma_clients_app/data/model/response_model/profile/profileResponseModel.dart';
import 'package:pharma_clients_app/data/model/response_model/selfAnalysisResponseModel.dart';
import 'package:pharma_clients_app/data/model/response_model/statesResponseModel.dart';
import 'package:pharma_clients_app/data/model/response_model/visits/vist_responseModel.dart';
import '../../../resources/app_urls.dart';
import '../../model/response_model/mrs/AddMrResponseModel.dart';
import '../../model/response_model/mrs/mrdelete_responseModel.dart';
import '../../model/response_model/products/product_reponse_model.dart';
import '../../model/response_model/visits/addVisitResponseModel.dart';
import '../../model/response_model/visual_aids_response_model.dart';
import '../../network/base_api_services.dart';
import '../../network/network_api_services.dart';

class AfterLoginRepository{

  BaseApiServices apiServices = NetworkApiServices();

  Future<DashBoardCountResponseModel> fetchCount() async {
    try{
      dynamic response =  await apiServices.getApiResponse(AppUrls.getDashboardCount);
      return response = DashBoardCountResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<ProductResponseModel> fetchProducts() async {
    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.getProducts, null);
      return response = ProductResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<VisualAidsResponseModel> fetchVisualAids() async {
    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.getVisualAids, null);
      return response = VisualAidsResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<DivisionResponseModel> fetchDivisions() async {
    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.getDivisions, null);
      return response = DivisionResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<OfferResponseModel> fetchOffers() async {
    try{
      dynamic response =  await apiServices.getApiResponse(AppUrls.getOffers);
      return response = OfferResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<CustomersResponseModel> fetchCustomers() async {
    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.getCustomers, null);
      return response = CustomersResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<CompanyOrderResponseModel> companyOrders() async {
    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.getMyOrder, null);
      return response = CompanyOrderResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<CustomerOrderResponseModel> customersOrders(data) async {
    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.customerOrder, data);
      return response = CustomerOrderResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<ProfileResponseModel> fetchProfile() async {
    try{
      dynamic response =  await apiServices.getApiResponse(AppUrls.getProfile);
      return response = ProfileResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<ProfileResponseModel> updateProfile(data) async {
    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.updateProfile, data);
      return response = ProfileResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<FirmResponseModel> fetchFirm() async {
    try{
      dynamic response =  await apiServices.getApiResponse(AppUrls.getFirm);
      return response = FirmResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<FirmResponseModel> updateFirm(data) async {
    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.firmUpdate,data);
      return response = FirmResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<AddCustomerResponseModel> addCustomer(dynamic data) async {
    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.addCustomer, data);
      return response = AddCustomerResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }
  Future<UpdateCustomerResponseModel> updateCustomer(dynamic data) async {
    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.updateCustomer, data);
      return response = UpdateCustomerResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<AddMrResponseModel> addMrs(dynamic data) async {
    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.addMR, data);
      return response = AddMrResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<MrsResponseModel> fetchMrs() async {
    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.getMrs, null);
      return response = MrsResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<MrsUpdateResponseModel> updateMrs(dynamic data) async {
    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.updateMr, data);
      return response = MrsUpdateResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<MrsDeleteResponseModel> deleteMrs(data) async {
    try{
      dynamic response =  await apiServices.deleteApiResponse('${AppUrls.deleteMr}/$data');
      return response = MrsDeleteResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<StatusResponseModel> statusMr(url) async {
    try{
      dynamic response =  await apiServices.getApiResponse(url);
      return response = StatusResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<ChangePasswordResponseModel> changePassword(data) async {
    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.changePassword, data);
      return response = ChangePasswordResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<ChangePasswordResponseModel> resetMrPassword(data) async {
    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.resetPassword, data);
      return response = ChangePasswordResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<VisitResponseModel> getVisits(data) async {
    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.getVisits, data);
      return response = VisitResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<AddVisitResponseModel> addVisits(data) async {
    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.addVisit, data);
      return response = AddVisitResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<StatesResponseModel> getStates() async {
    try{
      dynamic response =  await apiServices.getApiResponse(AppUrls.state);
      return response = StatesResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<CitiesResponseModel> getCities(data) async {
    try{
      dynamic response =  await apiServices.getApiResponse(AppUrls.state+data);
      return response = CitiesResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<FavouriteResponseModel> addToFav(data) async {
    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.addToFavouriteProduct, data);
      return response = FavouriteResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<FavouriteResponseModel> removeFav(data) async {
    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.deleteFavouriteProduct, data);
      return response = FavouriteResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<SelfAnalysisResponseModel> selfAnalysis() async {
    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.getWorkAnalysis, null);
      return response = SelfAnalysisResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<PlaceCustomerOrderResponseModel> placeCustomerOrder(data) async {
    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.addOrder, data);
      return response = PlaceCustomerOrderResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<PlaceOrderResponseModel> placeOrder(data) async {
    try{
      dynamic response =  await apiServices.postApiResponse(AppUrls.reOrder, data);
      return response = PlaceOrderResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

}