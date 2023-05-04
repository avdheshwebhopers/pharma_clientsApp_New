class CustomersResponseModel {
  bool? success;
  String? message;
  List<Customers>? data;

  CustomersResponseModel({this.success, this.message, this.data});

  CustomersResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Customers>[];
      json['data'].forEach((v) {
        data!.add(Customers.fromJson(v));
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

class Customers {
  String? id;
  String? name;
  String? email;
  int? phone;
  String? city;
  String? state;
  String? address;
  String? profession;
  RepId? repId;
  FranchiseeId? franchiseeId;
  String? workingPlace;
  String? dob;
  String? weddingAnniversary;
  String? createdOn;

  Customers(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.city,
      this.state,
      this.address,
      this.profession,
      this.repId,
      this.franchiseeId,
      this.workingPlace,
      this.dob,
      this.weddingAnniversary,
      this.createdOn});

  Customers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    city = json['city'];
    state = json['state'];
    address = json['address'];
    profession = json['profession'];
    repId = json['rep_id'] != null ? RepId.fromJson(json['rep_id']) : null;
    franchiseeId = json['franchisee_id'] != null
        ? FranchiseeId.fromJson(json['franchisee_id'])
        : null;
    workingPlace = json['working_place'];
    dob = json['dob'];
    weddingAnniversary = json['wedding_anniversary'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['city'] = city;
    data['state'] = state;
    data['address'] = address;
    data['profession'] = profession;
    if (repId != null) {
      data['rep_id'] = repId!.toJson();
    }
    if (franchiseeId != null) {
      data['franchisee_id'] = franchiseeId!.toJson();
    }
    data['working_place'] = workingPlace;
    data['dob'] = dob;
    data['wedding_anniversary'] = weddingAnniversary;
    data['created_on'] = createdOn;
    return data;
  }
}

class RepId {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? city;
  String? state;
  String? address;
  String? dob;
  String? opArea;
  String? profilePicUrl;
  String? franchiseeId;
  bool? isOwner;
  String? aadharNo;
  bool? active;
  String? deviceToken;
  String? createdOn;
  String? modifiedOn;

  RepId(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.city,
      this.state,
      this.address,
      this.dob,
      this.opArea,
      this.profilePicUrl,
      this.franchiseeId,
      this.isOwner,
      this.aadharNo,
      this.active,
      this.deviceToken,
      this.createdOn,
      this.modifiedOn});

  RepId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    city = json['city'];
    state = json['state'];
    address = json['address'];
    dob = json['dob'];
    opArea = json['op_area'];
    profilePicUrl = json['profile_pic_url'];
    franchiseeId = json['franchisee_id'];
    isOwner = json['is_owner'];
    aadharNo = json['aadhar_no'];
    active = json['active'];
    deviceToken = json['device_token'];
    createdOn = json['created_on'];
    modifiedOn = json['modified_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['city'] = city;
    data['state'] = state;
    data['address'] = address;
    data['dob'] = dob;
    data['op_area'] = opArea;
    data['profile_pic_url'] = profilePicUrl;
    data['franchisee_id'] = franchiseeId;
    data['is_owner'] = isOwner;
    data['aadhar_no'] = aadharNo;
    data['active'] = active;
    data['device_token'] = deviceToken;
    data['created_on'] = createdOn;
    data['modified_on'] = modifiedOn;
    return data;
  }
}

class FranchiseeId {
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

  FranchiseeId(
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

  FranchiseeId.fromJson(Map<String, dynamic> json) {
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
  String? createdOn;
  String? modifiedOn;

  Divisions({this.id, this.createdOn, this.modifiedOn});

  Divisions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdOn = json['created_on'];
    modifiedOn = json['modified_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_on'] = createdOn;
    data['modified_on'] = modifiedOn;
    return data;
  }
}
