class UpdateCustomerResponseModel {
  bool? success;
  String? message;
  Data? data;

  UpdateCustomerResponseModel({this.success, this.message, this.data});

  UpdateCustomerResponseModel.fromJson(Map<String, dynamic> json) {
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

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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
  String? email;
  String? aadharNo;
  String? address;
  String? dob;
  String? opArea;
  String? profilePicUrl;
  bool? active;
  bool? isOwner;
  String? deviceToken;
  String? sId;
  String? franchiseeId;
  String? name;
  String? city;
  String? state;
  String? phone;
  String? passwordHash;
  String? createdOn;
  String? modifiedOn;
  int? iV;

  RepId(
      {this.email,
        this.aadharNo,
        this.address,
        this.dob,
        this.opArea,
        this.profilePicUrl,
        this.active,
        this.isOwner,
        this.deviceToken,
        this.sId,
        this.franchiseeId,
        this.name,
        this.city,
        this.state,
        this.phone,
        this.passwordHash,
        this.createdOn,
        this.modifiedOn,
        this.iV});

  RepId.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    aadharNo = json['aadhar_no'];
    address = json['address'];
    dob = json['dob'];
    opArea = json['op_area'];
    profilePicUrl = json['profile_pic_url'];
    active = json['active'];
    isOwner = json['is_owner'];
    deviceToken = json['device_token'];
    sId = json['_id'];
    franchiseeId = json['franchisee_id'];
    name = json['name'];
    city = json['city'];
    state = json['state'];
    phone = json['phone'];
    passwordHash = json['password_hash'];
    createdOn = json['created_on'];
    modifiedOn = json['modified_on'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['aadhar_no'] = aadharNo;
    data['address'] = address;
    data['dob'] = dob;
    data['op_area'] = opArea;
    data['profile_pic_url'] = profilePicUrl;
    data['active'] = active;
    data['is_owner'] = isOwner;
    data['device_token'] = deviceToken;
    data['_id'] = sId;
    data['franchisee_id'] = franchiseeId;
    data['name'] = name;
    data['city'] = city;
    data['state'] = state;
    data['phone'] = phone;
    data['password_hash'] = passwordHash;
    data['created_on'] = createdOn;
    data['modified_on'] = modifiedOn;
    data['__v'] = iV;
    return data;
  }
}

class FranchiseeId {
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
  String? sId;
  String? name;
  String? createdOn;
  String? modifiedOn;
  int? iV;

  FranchiseeId(
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
        this.sId,
        this.name,
        this.createdOn,
        this.modifiedOn,
        this.iV});

  FranchiseeId.fromJson(Map<String, dynamic> json) {
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
    sId = json['_id'];
    name = json['name'];
    createdOn = json['created_on'];
    modifiedOn = json['modified_on'];
    iV = json['__v'];
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
    data['_id'] = sId;
    data['name'] = name;
    data['created_on'] = createdOn;
    data['modified_on'] = modifiedOn;
    data['__v'] = iV;
    return data;
  }
}