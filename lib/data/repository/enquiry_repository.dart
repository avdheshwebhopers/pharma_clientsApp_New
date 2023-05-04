import 'package:pharma_clients_app/data/model/response_model/enquiry_model.dart';
import 'package:pharma_clients_app/data/network/base_api_services.dart';
import 'package:pharma_clients_app/data/network/network_api_services.dart';

import '../../resources/app_urls.dart';

class EnquiryRepository{

  BaseApiServices apiServices = NetworkApiServices();

  Future<EnquiryResponseModel> postEnquiry(dynamic data) async {

    try{
      dynamic response =  await apiServices.putApiResponse(AppUrls.enquiryApi, data);
      return response = EnquiryResponseModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

}