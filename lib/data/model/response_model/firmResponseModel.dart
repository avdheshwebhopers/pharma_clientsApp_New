class FirmResponseModel {
  bool? success;
  String? message;
  Data? data;

  FirmResponseModel({this.success, this.message, this.data});

  FirmResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? name;
  String? gstNumber;
  String? drugLicense;
  String? email;
  String? phone;
  String? address;
  String? state;
  String? district;
  String? logoUrl;
  List<Divisions>? divisions;
  bool? active;
  String? bankAccNo;
  String? bankIfsc;
  String? bankName;
  String? bankPayeeName;
  String? createdOn;
  String? modifiedOn;

  Data(
      {this.id,
        this.name,
        this.gstNumber,
        this.drugLicense,
        this.email,
        this.phone,
        this.address,
        this.state,
        this.district,
        this.logoUrl,
        this.divisions,
        this.active,
        this.bankAccNo,
        this.bankIfsc,
        this.bankName,
        this.bankPayeeName,
        this.createdOn,
        this.modifiedOn});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gstNumber = json['gst_number'];
    drugLicense = json['drug_license'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    state = json['state'];
    district = json['district'];
    logoUrl = json['logo_url'];
    if (json['divisions'] != null) {
      divisions = <Divisions>[];
      json['divisions'].forEach((v) {
        divisions!.add(Divisions.fromJson(v));
      });
    }
    active = json['active'];
    bankAccNo = json['bank_acc_no'];
    bankIfsc = json['bank_ifsc'];
    bankName = json['bank_name'];
    bankPayeeName = json['bank_payee_name'];
    createdOn = json['created_on'];
    modifiedOn = json['modified_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['gst_number'] = gstNumber;
    data['drug_license'] = drugLicense;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['state'] = state;
    data['district'] = district;
    data['logo_url'] = logoUrl;
    if (divisions != null) {
      data['divisions'] = divisions!.map((v) => v.toJson()).toList();
    }
    data['active'] = active;
    data['bank_acc_no'] = bankAccNo;
    data['bank_ifsc'] = bankIfsc;
    data['bank_name'] = bankName;
    data['bank_payee_name'] = bankPayeeName;
    data['created_on'] = createdOn;
    data['modified_on'] = modifiedOn;
    return data;
  }
}

class Divisions {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  bool? active;
  String? createdOn;
  String? modifiedOn;

  Divisions(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.address,
        this.active,
        this.createdOn,
        this.modifiedOn});

  Divisions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    active = json['active'];
    createdOn = json['created_on'];
    modifiedOn = json['modified_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['active'] = active;
    data['created_on'] = createdOn;
    data['modified_on'] = modifiedOn;
    return data;
  }
}

