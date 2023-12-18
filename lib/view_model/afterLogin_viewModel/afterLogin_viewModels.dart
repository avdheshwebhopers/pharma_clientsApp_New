import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pharma_clients_app/data/model/requested_data_model/cartEntity.dart';
import 'package:pharma_clients_app/data/model/response_model/firmResponseModel.dart';
import 'package:pharma_clients_app/data/model/response_model/selfAnalysisResponseModel.dart';
import 'package:pharma_clients_app/data/model/response_model/statesResponseModel.dart';
import 'package:pharma_clients_app/data/model/response_model/visits/vist_responseModel.dart';
import 'package:pharma_clients_app/resources/constant_strings.dart';
import 'package:pharma_clients_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/model/requested_data_model/notificationData.dart';
import '../../data/model/response_model/Orders/companyOrder_responseModel.dart';
import '../../data/model/response_model/Orders/customersOrder_responseModel.dart';
import '../../data/model/response_model/count/db_count_responsemodel.dart';
import '../../data/model/response_model/customers/customers_responseModel.dart';
import '../../data/model/response_model/division_responseModel.dart';
import '../../data/model/response_model/mrs/mrs_responseModel.dart';
import '../../data/model/response_model/offers_reposnseModel.dart';
import '../../data/model/response_model/products/product_reponse_model.dart';
import '../../data/model/response_model/profile/profileResponseModel.dart';
import '../../data/model/response_model/visual_aids_response_model.dart';
import '../../data/repository/afterLogin/afterLogin_repository.dart';
import '../../data/response/api_response.dart';
import '../../views/AddScreen/AddVisitScreen.dart';

class ProductViewModel with ChangeNotifier {
  List<Products> product = [];
  List<Products> _selectedProducts = [];
  List<Products> get selectedProducts => _selectedProducts;
  List<Products> _filteredProducts = [];
  List<Products> get products => _filteredProducts;
  List<Products> _favProducts = [];
  List<Products> get favProducts => _favProducts;
  List<Products> _newLaunched = [];
  List<Products> get newLaunched => _newLaunched;
  List<Products> _upcoming = [];
  List<Products> get upcoming => _upcoming;
  bool get isSelectionMode => _selectedProducts.isNotEmpty;

  final _myRepo = AfterLoginRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchProductsApi() async {
    setLoading(true);
    _myRepo.fetchProducts().then((value) {
      for (var element in value.data!) {
        if (element.active == true) {
          product.add(element);
          if(element.favourite == true){
            favProducts.add(element);
          }
          if(element.newLaunched == true){
            _newLaunched.add(element);
          }
          if(element.upcoming == true){
            _upcoming.add(element);
          }
        }
      }
      _filteredProducts = product;
      notifyListeners();
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  void filterItems(String searchQuery) {
    _filteredProducts = product.where((element) {
      return element.name!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          element.typeName!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          element.categoryName!.toLowerCase().contains(searchQuery.toLowerCase()) ||
      element.description!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
    notifyListeners();
  }

  void filterByDivision(List<String> searchQuery) {
    _filteredProducts = product
        .where((element) =>
            searchQuery.isEmpty ||
            searchQuery.any((query) => element.divisionName!
                .toLowerCase()
                .contains(query.toLowerCase())))
        .toList();
    notifyListeners();
  }

  void toggleSelection(Products product) {
    if (_selectedProducts.contains(product)) {
      _selectedProducts.remove(product);
    } else {
      _selectedProducts.add(product);
    }
    notifyListeners();
  }

  bool isSelected(Products product) {
    return _selectedProducts.contains(product);
  }

  void clearSelection() {
    _selectedProducts.clear();
    notifyListeners();
  }

}

class DbCountViewModel with ChangeNotifier {
  final _myRepo = AfterLoginRepository();

  Count? data;

  Count? get dataa => data;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchCountApi(BuildContext context) async {
    setLoading(true);
    _myRepo.fetchCount().then((value) {
      data = value.data;
      if (value.success != true) {
        Utils.errorAlertDialogue("Error in Communication", context);
      }
      notifyListeners();
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

class VisualAidsViewModel with ChangeNotifier {

  List<VisualAids> visualAid = [];
  List<VisualAids> _filteredVisualAids = [];
  List<VisualAids> _selectedVisualAids = [];
  List<VisualAids> get visualAids => _filteredVisualAids;
  List<VisualAids> get selectedVisualAids => _selectedVisualAids;
  bool get isSelectionMode => _selectedVisualAids.isNotEmpty;

  final _myRepo = AfterLoginRepository();

  ApiResponse<VisualAidsResponseModel> visualaidsList = ApiResponse.loading();

  setAboutCompanyList(ApiResponse<VisualAidsResponseModel> response) {
    visualaidsList = response;
    notifyListeners();
  }

  Future<void> fetchVisualAids() async {
    setAboutCompanyList(ApiResponse.loading());

    _myRepo.fetchVisualAids().then((value) {
      for (var element in value.data!) {
        if (element.url != null) {
          visualAid.add(element);
        }
      }
      _filteredVisualAids = visualAid;
      notifyListeners();

      setAboutCompanyList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setAboutCompanyList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  void filteredVisuals(String searchQuery) {
    _filteredVisualAids = visualAid.where((element) {
      return element.name!.toLowerCase().contains(searchQuery.toLowerCase())||
      element.category!.toLowerCase().contains(searchQuery.toLowerCase())||
      element.division!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
    notifyListeners();
  }

  void toggleSelection(VisualAids product) {
    if (_selectedVisualAids.contains(product)) {
      _selectedVisualAids.remove(product);
    } else {
      _selectedVisualAids.add(product);
    }
    notifyListeners();
  }

  bool isSelected(VisualAids product) {
    return _selectedVisualAids.contains(product);
  }

  void clearSelection() {
    _selectedVisualAids.clear();
    notifyListeners();
  }

}

class DivisionsViewModel with ChangeNotifier {
  final _myRepo = AfterLoginRepository();

  ApiResponse<DivisionResponseModel> divisionList = ApiResponse.loading();

  setDivisionList(ApiResponse<DivisionResponseModel> response) {
    divisionList = response;
    notifyListeners();
  }

  Future<void> fetchDivisions() async {
    setDivisionList(ApiResponse.loading());

    _myRepo.fetchDivisions().then((value) {
      setDivisionList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setDivisionList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

class AddCustomerViewModel with ChangeNotifier {
  final _myRepo = AfterLoginRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> addCustomers(
      dynamic data,
      BuildContext context,
      TextEditingController name,
      TextEditingController email,
      TextEditingController phone,
      TextEditingController address,
      TextEditingController profession,
      TextEditingController hospitalName,
      TextEditingController dob,
      TextEditingController weddingDate) async {
    setLoading(true);

    _myRepo.addCustomer(data).then((value) {
      setLoading(false);
      if (value.success == true) {
        Utils.flushBarSuccessMessage(ConstantStrings.customerAdded, context);
        name.clear();
        email.clear();
        phone.clear();
        address.clear();
        profession.clear();
        hospitalName.clear();
        dob.clear();
        weddingDate.clear();
      } else {
        Utils.errorAlertDialogue(value.message.toString(), context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> updateCustomers(
      dynamic data,
      BuildContext context,
      TextEditingController name,
      TextEditingController email,
      TextEditingController phone,
      TextEditingController address,
      TextEditingController profession,
      TextEditingController hospitalName,
      TextEditingController dob,
      TextEditingController weddingDate) async {
    setLoading(true);

    _myRepo.updateCustomer(data).then((value) {
      setLoading(false);
      if (value.success == true) {
        Utils.flushBarSuccessMessage(ConstantStrings.customerUpdated, context);
        name.clear();
        email.clear();
        phone.clear();
        address.clear();
        profession.clear();
        hospitalName.clear();
        dob.clear();
        weddingDate.clear();
      } else {
        Utils.errorAlertDialogue(value.message.toString(), context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

class CustomersViewModel with ChangeNotifier {
  final _myRepo = AfterLoginRepository();

  ApiResponse<CustomersResponseModel> customersList = ApiResponse.loading();

  setCustomersList(ApiResponse<CustomersResponseModel> response) {
    customersList = response;
    notifyListeners();
  }

  Future<void> fetchCustomers() async {
    setCustomersList(ApiResponse.loading());

    _myRepo.fetchCustomers().then((value) {
      setCustomersList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCustomersList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

class VisitViewModel with ChangeNotifier {
  final _myRepo = AfterLoginRepository();

  ApiResponse<VisitResponseModel> visitList = ApiResponse.loading();

  setVisitList(ApiResponse<VisitResponseModel> response) {
    visitList = response;
    notifyListeners();
  }

  Future<void> getVisits(data) async {
    setVisitList(ApiResponse.loading());

    _myRepo.getVisits(data).then((value) {
      setVisitList(ApiResponse.completed(value));

      print(value.success);
    }).onError((error, stackTrace) {
      setVisitList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

class AddVisitViewModel with ChangeNotifier {
  final _myRepo = AfterLoginRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> addVisits(
      BuildContext context, 
      data,
      TextEditingController timeinput,
      TextEditingController currentAddress,
      TextEditingController message
      ) async {
    setLoading(true);

    _myRepo.addVisits(data).then((value) {
      setLoading(false);
      if(value.success == true){
        timeinput.clear();
        currentAddress.clear();
        message.clear();
        Utils.flushBarSuccessMessage("Visit Added Successfully", context);
      }else{
        Utils.flushBarErrorMessage("${value.message}", context);
      }



    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

class CompanyOrderViewModel with ChangeNotifier {
  final _myRepo = AfterLoginRepository();

  ApiResponse<CompanyOrderResponseModel> myOrderList = ApiResponse.loading();

  setMyOrderList(ApiResponse<CompanyOrderResponseModel> response) {
    myOrderList = response;
    notifyListeners();
  }

  Future<void> fetchCompanyOrders() async {
    setMyOrderList(ApiResponse.loading());

    _myRepo.companyOrders().then((value) {
      setMyOrderList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setMyOrderList(ApiResponse.error(error.toString()));

      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

class CustomerOrderViewModel with ChangeNotifier {
  List order = [];

  final _myRepo = AfterLoginRepository();

  ApiResponse<CustomerOrderResponseModel> customersOrderList =
      ApiResponse.loading();

  setCustomersOrderList(ApiResponse<CustomerOrderResponseModel> response) {
    customersOrderList = response;
    notifyListeners();
  }

  Future<void> fetchCustomersOrders(data) async {
    setCustomersOrderList(ApiResponse.loading());

    _myRepo.customersOrders(data).then((value) {
      setCustomersOrderList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCustomersOrderList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

class OffersViewModel with ChangeNotifier {
  final _myRepo = AfterLoginRepository();

  ApiResponse<OfferResponseModel> offersList = ApiResponse.loading();

  setOffersList(ApiResponse<OfferResponseModel> response) {
    offersList = response;
    notifyListeners();
  }

  Future<void> fetchOffers() async {
    setOffersList(ApiResponse.loading());

    _myRepo.fetchOffers().then((value) {
      setOffersList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setOffersList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

class ProfileViewModel with ChangeNotifier {
  final _myRepo = AfterLoginRepository();

  ApiResponse<ProfileResponseModel> profile = ApiResponse.loading();

  setOffersList(ApiResponse<ProfileResponseModel> response) {
    profile = response;
    notifyListeners();
  }

  Future<void> fetchProfile() async {
    setOffersList(ApiResponse.loading());

    _myRepo.fetchProfile().then((value) {
      setOffersList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setOffersList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

class UpdateProfileViewModel with ChangeNotifier {
  final _myRepo = AfterLoginRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> updateProfile(
      dynamic data,
      BuildContext context,
      TextEditingController name,
      TextEditingController email,
      TextEditingController phone,
      TextEditingController aadhaar,
      TextEditingController address,
      TextEditingController dob,
      TextEditingController opArea) async {
    setLoading(true);

    _myRepo.updateProfile(data).then((value) async {
      setLoading(false);

      if (value.success == true) {
        name.clear();
        email.clear();
        phone.clear();
        aadhaar.clear();
        address.clear();
        dob.clear();
        opArea.clear();

        final provider = Provider.of<StatesViewModel>(context, listen: false);
        provider.state.clear();

        Utils.flushBarSuccessMessage("Profile Updated Successfully", context);
        // Utils.successAlertDialogue(ConstantStrings.mrsDelete, (){Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => const MrsScreen()));}, context);
      } else {
        Utils.errorAlertDialogue(value.message.toString(), context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

class FirmViewModel with ChangeNotifier {
  final _myRepo = AfterLoginRepository();

  ApiResponse<FirmResponseModel> firm = ApiResponse.loading();

  setFirmList(ApiResponse<FirmResponseModel> response) {
    firm = response;
    notifyListeners();
  }

  Future<void> fetchFirm() async {
    setFirmList(ApiResponse.loading());

    _myRepo.fetchFirm().then((value) {
      setFirmList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setFirmList(ApiResponse.error(error.toString()));

      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

class UpdateFirmViewModel with ChangeNotifier {
  final _myRepo = AfterLoginRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> updateFirm(
      dynamic data,
      BuildContext context,
      TextEditingController name,
      TextEditingController gst,
      TextEditingController drug_liscense,
      TextEditingController phone,
      TextEditingController email,
      TextEditingController address,
      TextEditingController bankName,
      TextEditingController AccNumber,
      TextEditingController ifsc,
      TextEditingController payee) async {
    setLoading(true);

    _myRepo.updateFirm(data).then((value) async {
      setLoading(false);

      if (value.success == true) {
        name.clear();
        gst.clear();
        drug_liscense.clear();
        email.clear();
        phone.clear();
        bankName.clear();
        address.clear();
        AccNumber.clear();
        ifsc.clear();
        payee.clear();

        Utils.flushBarSuccessMessage("Firm Updated Successfully", context);
        // Utils.successAlertDialogue(ConstantStrings.mrsDelete, (){Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => const MrsScreen()));}, context);
      } else {
        Utils.errorAlertDialogue(value.message.toString(), context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

class ChangePasswordViewModel with ChangeNotifier {
  final _myRepo = AfterLoginRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> changePassword(
      dynamic data,
      BuildContext context,
      TextEditingController oldPassword,
      TextEditingController newPassword,
      TextEditingController confirmPassword) async {
    setLoading(true);
    _myRepo.changePassword(data).then((value) async {
      setLoading(false);

      if (value.success == true) {
        oldPassword.clear();
        newPassword.clear();
        confirmPassword.clear();
        Utils.flushBarSuccessMessage(ConstantStrings.changePassword, context);
      } else {
        Utils.errorAlertDialogue(value.message.toString(), context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

class ResetMrPasswordViewModel with ChangeNotifier{

  bool _loading = false ;
  bool get loading => _loading;

  final _myRepo = AfterLoginRepository();

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> resetMrPassword(data, BuildContext context ,

      TextEditingController newPassword,
      TextEditingController confirmPassword,

      ) async {

    setLoading(true);

    _myRepo.resetMrPassword(data).then((value){
      setLoading(false);
      if(value.success == true){

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => const LoginScreen()));

        newPassword.clear();
        confirmPassword.clear();
        
        Utils.flushBarSuccessMessage('Password Updated Successfully', context);
  
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

class MrsViewModel with ChangeNotifier {
  final _myRepo = AfterLoginRepository();

  bool _color = false;
  bool get color => _color;

  bool _loading = false;
  bool get loading => _loading;

  ApiResponse<MrsResponseModel> mrsList = ApiResponse.loading();

  setMrsList(ApiResponse<MrsResponseModel> response) {
    mrsList = response;
    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setColor(bool value) {
    _color = value;
    notifyListeners();
  }

  Future<void> fetchMrs() async {
    setMrsList(ApiResponse.loading());
    _myRepo.fetchMrs().then((value) {
      setMrsList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setMrsList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> statusMr(url, BuildContext context) async {
    setLoading(true);
    _myRepo.statusMr(url).then((value) async {
      setLoading(false);
      if (value.success == true) {
        setColor(value.data!.active!);
        if(value.data!.active == true){
          Utils.flushBarSuccessMessage(ConstantStrings.mrActivated, context);
        }else {
          Utils.flushBarSuccessMessage(ConstantStrings.mrDeActivated,context);
        }
      } else {
        Utils.errorAlertDialogue(value.message.toString(), context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

class UpdateMrViewModel with ChangeNotifier {
  final _myRepo = AfterLoginRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> updateMrs(dynamic data, BuildContext context) async {
    setLoading(true);

    _myRepo.updateMrs(data).then((value) {
      setLoading(false);
      if (value.success == true) {
        Utils.flushBarSuccessMessage(ConstantStrings.mrsUpdated, context);
      } else {
        Utils.errorAlertDialogue(value.message.toString(), context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

class DeleteMrViewModel with ChangeNotifier {
  final _myRepo = AfterLoginRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> deleteMrs(dynamic data, BuildContext context) async {
    setLoading(true);

    _myRepo.deleteMrs(data).then((value) async {
      setLoading(false);
      if (value.success == true) {
        Utils.flushBarSuccessMessage(ConstantStrings.mrsDelete, context);
        // await Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => const MrsScreen()));
      } else {
        Utils.errorAlertDialogue(value.message.toString(), context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

class StatusMrViewModel with ChangeNotifier {
  final _myRepo = AfterLoginRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _color = false;
  bool get color => _color;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> statusMr(url, BuildContext context) async {
    setLoading(true);
    _myRepo.statusMr(url).then((value) async {
      setLoading(false);
      if (value.success == true) {
        //_color = value.data!.active!;
        if(value.data!.active == true){
          Utils.flushBarSuccessMessage(ConstantStrings.mrActivated,context);
        }else {
          Utils.flushBarSuccessMessage(ConstantStrings.mrDeActivated,context);
        }
         setColor(value.data!.active!);
      } else {
        Utils.errorAlertDialogue(value.message.toString(), context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  setColor(bool value) {
    _color = value;
    notifyListeners();
  }
}

class AddMrViewModel with ChangeNotifier {
  final _myRepo = AfterLoginRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> addMr(
      dynamic data,
      BuildContext context,
      TextEditingController name,
      TextEditingController email,
      TextEditingController phone,
      TextEditingController address,
      TextEditingController dob,
      TextEditingController opArea,
      TextEditingController password,
      TextEditingController confrimPassword) async {
    setLoading(true);
    _myRepo.addMrs(data).then((value) async {
      setLoading(false);

      if (value.success == true) {
        name.clear();
        email.clear();
        phone.clear();
        address.clear();
        dob.clear();
        opArea.clear();
        password.clear();
        confrimPassword.clear();

        Utils.flushBarSuccessMessage("Mr Added Successfully", context);
        // Utils.successAlertDialogue(ConstantStrings.mrsDelete, (){Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => const MrsScreen()));}, context);
      } else {
        Utils.errorAlertDialogue(value.message.toString(), context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

class StatesViewModel with ChangeNotifier {
  final _myRepo = AfterLoginRepository();

  bool _loading = false;

  bool get loading => _loading;

  List<States> _state = [];

  List<States> get state => _state;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> states(BuildContext context) async {
    setLoading(true);

    _myRepo.getStates().then((value) {
      setLoading(false);
      if (value.success == true) {
        for (var element in value.data!) {
          _state.add(States(id: element.id, name: element.name));
        }
      } else {
        Utils.errorAlertDialogue(value.message.toString(), context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

class CitiesViewModel with ChangeNotifier {
  final _myRepo = AfterLoginRepository();

  bool _loading = false;

  bool get loading => _loading;

  List<String> _cities = [];

  List<String> get city => _cities;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> cities(data, BuildContext context) async {
    setLoading(true);

    _myRepo.getCities(data).then((value) {
      setLoading(false);
      if (value.success == true) {
        _cities.clear();
        for (var element in value.data!) {
          _cities.add(element);
        }
      } else {
        Utils.errorAlertDialogue(value.message.toString(), context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

class FirmCitiesViewModel with ChangeNotifier {
  final _myRepo = AfterLoginRepository();

  bool _loading = false;

  bool get loading => _loading;

  List<String> _cities = [];

  List<String> get city => _cities;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> cities(data, BuildContext context) async {
    setLoading(true);

    _myRepo.getCities(data).then((value) {
      setLoading(false);
      if (value.success == true) {
        _cities.clear();
        for (var element in value.data!) {
          _cities.add(element);
        }
        Utils.flushBarSuccessMessage(ConstantStrings.mrsUpdated, context);
      } else {
        Utils.errorAlertDialogue(value.message.toString(), context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

class AddtoFavViewModel with ChangeNotifier {
  final _myRepo = AfterLoginRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> addTofav(data, BuildContext context) async {
    setLoading(true);

    _myRepo.addToFav(data).then((value) {
      setLoading(false);
      if (value.success == true) {
        Utils.flushBarSuccessMessage(ConstantStrings.favProductsAdded, context);
      } else {
        Utils.errorAlertDialogue(value.message.toString(), context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> removeFav(data, BuildContext context, List remove) async {
    setLoading(true);
    _myRepo.removeFav(data).then((value) {
      setLoading(false);
      if (value.success == true) {
        Utils.flushBarSuccessMessage(ConstantStrings.favProductsRemoved, context);
        remove.clear();
      } else {
        Utils.errorAlertDialogue(value.message.toString(), context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

class Cart extends ChangeNotifier {
  List<CartEntity> _items = [];

  List<CartEntity> get items => _items;

  int get totalCount => _items.length;

  int get quantity => _items.length;

  double get totalPrice => _items.fold(0, (sum, item) => sum + item.price * item.quantity);

  int itemCount(String? id) {
    return _items.where((item) => item.id == id).length;
  }

  void addItem(CartEntity item) {
    final index = _items.indexWhere((i) => i.id == item.id);
    if (index != -1) {
      _items[index].quantity++;
    } else {
      _items.add(item);
    }
    saveCart();
    notifyListeners();
  }

  void removeItem(CartEntity item) {
    final index = _items.indexWhere((i) => i.id == item.id);
    if (index != -1) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      saveCart();
      notifyListeners();
    }
  }

  void updateItemQuantity(CartEntity item, int quantity) {
    final index = _items.indexWhere((i) => i.id == item.id);
    if (index != -1) {
      _items[index].quantity = quantity;
      if (_items[index].quantity == 0) {
        _items.removeAt(index);
      }
      notifyListeners();
      saveCart();
    }
  }

  void clear() {
    _items.clear();
    saveCart();
    notifyListeners();
  }

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cart');
    if (cartData != null) {
      final List<dynamic> list = jsonDecode(cartData);
      if (kDebugMode) {
        print(list);
      };
      _items = list.map((item) => CartEntity.fromJson(item)).toList();
      notifyListeners();
    }
  }

  Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = jsonEncode(_items.map((item) => item.toJson()).toList());
    await prefs.setString('cart', cartData);
  }

}

class SelfAnalysisViewModel with ChangeNotifier {

  final _myRepo = AfterLoginRepository();

  ApiResponse<SelfAnalysisResponseModel> analysisList = ApiResponse.loading();

  setAnalysisList(ApiResponse<SelfAnalysisResponseModel> response) {
    analysisList = response;
    notifyListeners();
  }

  Future<void> selfAnalysis(BuildContext context) async {
    _myRepo.selfAnalysis().then((value) {
      setAnalysisList(ApiResponse.loading());
      if (value.success == true) {
        setAnalysisList(ApiResponse.completed(value));
      } else {
        Utils.errorAlertDialogue(value.message.toString(), context);
      }
    }).onError((error, stackTrace) {
      setAnalysisList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

class ProProvider extends ChangeNotifier {
  List<Products> _selectedProducts = [];
  List<Products> get selectedProducts => _selectedProducts;

  void addDivision(Products product) {
    _selectedProducts.add(product);
    notifyListeners();
  }

  void removeDivision(Products product) {
    _selectedProducts.remove(product);
    notifyListeners();
  }

  bool isSelected(Products product) {
    return _selectedProducts.contains(product);
  }
}

class PlaceOrderViewModel with ChangeNotifier {
  final _myRepo = AfterLoginRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> placeOrder(data, BuildContext context) async {
    final provider = Provider.of<Cart>(context,listen: false);
    setLoading(true);

    _myRepo.placeOrder(data).then((value) {
      setLoading(false);
      if (value.success == true) {
        Utils.flushBarSuccessMessage(ConstantStrings.orderPlaced, context);
        provider.clear();
      } else {
        Utils.errorAlertDialogue(value.message.toString(), context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> placeCustomerOrder(data, BuildContext context, name) async {
    final provider = Provider.of<Cart>(context,listen: false);
    setLoading(true);

    _myRepo.placeCustomerOrder(data).then((value) {
      setLoading(false);
      if (value.success == true) {
        Utils.successAlertDialogue('${ConstantStrings.orderPlacedCus}$name',(){Navigator.pop(context);}, context);
        provider.clear();
      } else {
        Utils.errorAlertDialogue(value.message.toString(), context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

class NotificationList with ChangeNotifier {
  List<NotificationData> _notifications = [];

  List<NotificationData> get notifications => _notifications;

  Future<void> loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final notificationsJson = prefs.getString('notifications');
    if (notificationsJson != null) {
      final notificationsList = jsonDecode(notificationsJson) as List<dynamic>;
      _notifications =
          notificationsList.map((json) => NotificationData.fromJson(json)).toList();
    }
  }

  Future<void> addNotification(NotificationData notification) async {
    _notifications.add(notification);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final notificationsJson = jsonEncode(_notifications.map((n) => n.toJson()).toList());
    await prefs.setString('notifications', notificationsJson);
  }

  Future<void> removeNotification(int index) async {
    _notifications.removeAt(index);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final notificationsJson = jsonEncode(_notifications.map((n) => n.toJson()).toList());
    await prefs.setString('notifications', notificationsJson);
  }

  Future<void> clearNotifications() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('notifications');
    notifyListeners();
  }
}
