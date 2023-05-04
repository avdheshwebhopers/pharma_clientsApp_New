class AddCustomerResponseModel {
  bool? success;
  String? message;
  Data? data;

  AddCustomerResponseModel({this.success, this.message, this.data});

  AddCustomerResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? address;
  String? email;
  bool? active;
  String? profession;
  String? workingPlace;
  String? dob;
  String? weddingAnniversary;
  String? name;
  String? city;
  String? state;
  int? phone;
  String? repId;
  String? franchiseeId;
  String? sId;

  Data(
      {this.address,
        this.email,
        this.active,
        this.profession,
        this.workingPlace,
        this.dob,
        this.weddingAnniversary,
        this.name,
        this.city,
        this.state,
        this.phone,
        this.repId,
        this.franchiseeId,
        this.sId});

  Data.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    email = json['email'];
    active = json['active'];
    profession = json['profession'];
    workingPlace = json['working_place'];
    dob = json['dob'];
    weddingAnniversary = json['wedding_anniversary'];
    name = json['name'];
    city = json['city'];
    state = json['state'];
    phone = json['phone'];
    repId = json['rep_id'];
    franchiseeId = json['franchisee_id'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['email'] = email;
    data['active'] = active;
    data['profession'] = profession;
    data['working_place'] = workingPlace;
    data['dob'] = dob;
    data['wedding_anniversary'] = weddingAnniversary;
    data['name'] = name;
    data['city'] = city;
    data['state'] = state;
    data['phone'] = phone;
    data['rep_id'] = repId;
    data['franchisee_id'] = franchiseeId;
    data['_id'] = sId;
    return data;
  }
}