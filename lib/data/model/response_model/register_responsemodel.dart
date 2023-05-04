
class RegisterResponseModel {
  bool? success;
  String? message;
  List<Data>? data;

  RegisterResponseModel({this.success, this.message, this.data});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  FranchiseeInfo? franchiseeInfo;
  RepInfo? repInfo;

  Data({this.franchiseeInfo, this.repInfo});

  Data.fromJson(Map<String, dynamic> json) {
    franchiseeInfo = json['franchiseeInfo'] != null
        ? FranchiseeInfo.fromJson(json['franchiseeInfo'])
        : null;
    repInfo =
    json['repInfo'] != null ? RepInfo.fromJson(json['repInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (franchiseeInfo != null) {
      data['franchiseeInfo'] = franchiseeInfo!.toJson();
    }
    if (repInfo != null) {
      data['repInfo'] = repInfo!.toJson();
    }
    return data;
  }
}

class FranchiseeInfo {
  String? gstNumber;
  String? drugLicense;
  String? phone;
  String? email;
  String? address;
  String? state;
  String? district;
  List<String>? divisions;
  String? logoUrl;
  String? bankAccNo;
  String? bankIfsc;
  String? bankName;
  String? bankPayeeName;
  bool? active;
  String? name;
  String? sId;

  FranchiseeInfo(
      {this.gstNumber,
        this.drugLicense,
        this.phone,
        this.email,
        this.address,
        this.state,
        this.district,
        this.divisions,
        this.logoUrl,
        this.bankAccNo,
        this.bankIfsc,
        this.bankName,
        this.bankPayeeName,
        this.active,
        this.name,
        this.sId});

  FranchiseeInfo.fromJson(Map<String, dynamic> json) {
    gstNumber = json['gst_number'];
    drugLicense = json['drug_license'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    state = json['state'];
    district = json['district'];
    divisions = json['divisions'].cast<String>();
    logoUrl = json['logo_url'];
    bankAccNo = json['bank_acc_no'];
    bankIfsc = json['bank_ifsc'];
    bankName = json['bank_name'];
    bankPayeeName = json['bank_payee_name'];
    active = json['active'];
    name = json['name'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gst_number'] = gstNumber;
    data['drug_license'] = drugLicense;
    data['phone'] = phone;
    data['email'] = email;
    data['address'] = address;
    data['state'] = state;
    data['district'] = district;
    data['divisions'] = divisions;
    data['logo_url'] = logoUrl;
    data['bank_acc_no'] = bankAccNo;
    data['bank_ifsc'] = bankIfsc;
    data['bank_name'] = bankName;
    data['bank_payee_name'] = bankPayeeName;
    data['active'] = active;
    data['name'] = name;
    data['_id'] = sId;
    return data;
  }
}

class RepInfo {
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

  RepInfo(
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

  RepInfo.fromJson(Map<String, dynamic> json) {
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