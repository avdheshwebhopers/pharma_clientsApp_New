class AddMrResponseModel {
  bool? success;
  String? message;
  Data? data;

  AddMrResponseModel({this.success, this.message, this.data});

  AddMrResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? email;
  String? aadharNo;
  String? address;
  String? dob;
  String? opArea;
  String? profilePicUrl;
  bool? isOwner;
  String? deviceToken;
  String? franchiseeId;
  String? name;
  String? city;
  String? state;
  String? phone;
  String? sId;

  Data(
      {this.email,
        this.aadharNo,
        this.address,
        this.dob,
        this.opArea,
        this.profilePicUrl,
        this.isOwner,
        this.deviceToken,
        this.franchiseeId,
        this.name,
        this.city,
        this.state,
        this.phone,
        this.sId});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    aadharNo = json['aadhar_no'];
    address = json['address'];
    dob = json['dob'];
    opArea = json['op_area'];
    profilePicUrl = json['profile_pic_url'];
    isOwner = json['is_owner'];
    deviceToken = json['device_token'];
    franchiseeId = json['franchisee_id'];
    name = json['name'];
    city = json['city'];
    state = json['state'];
    phone = json['phone'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['aadhar_no'] = aadharNo;
    data['address'] = address;
    data['dob'] = dob;
    data['op_area'] = opArea;
    data['profile_pic_url'] = profilePicUrl;
    data['is_owner'] = isOwner;
    data['device_token'] = deviceToken;
    data['franchisee_id'] = franchiseeId;
    data['name'] = name;
    data['city'] = city;
    data['state'] = state;
    data['phone'] = phone;
    data['_id'] = sId;
    return data;
  }
}