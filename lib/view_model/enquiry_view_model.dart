import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:pharma_clients_app/data/model/response_model/enquiry_model.dart';
import 'package:pharma_clients_app/data/repository/enquiry_repository.dart';
import 'package:pharma_clients_app/utils/utils.dart';
import '../data/response/api_response.dart';

class EnquiryViewModel with ChangeNotifier{

  final _myRepo = EnquiryRepository();

  bool _loading = false ;
  bool get loading => _loading ;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> postEnquiry(dynamic data,
      BuildContext context,
      TextEditingController name,
      TextEditingController email,
      TextEditingController phone,
      TextEditingController message
      ) async {

    setLoading(true);
    _myRepo.postEnquiry(data).then((value){
      setLoading(false);
      if(value.success == true){
        name.clear();
        email.clear();
        phone.clear();
        message.clear();
        Utils.flushBarSuccessMessage(value.message.toString(), context);
      }else{
        Utils.flushBarErrorMessage(value.message.toString(), context);
      }

    }).onError((error, stackTrace){
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

}