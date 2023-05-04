class MrsResponseModel {
  bool? success;
  String? message;
  List<Mrs>? data;

  MrsResponseModel({this.success, this.message, this.data});

  MrsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Mrs>[];
      json['data'].forEach((v) {
        data!.add(Mrs.fromJson(v));
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

class Mrs {
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
  String? franchiseeName;
  bool? isOwner;
  String? aadharNo;
  bool? active;
  String? deviceToken;
  String? createdOn;
  String? modifiedOn;

  Mrs(
      {
        this.id,
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
        this.franchiseeName,
        this.isOwner,
        this.aadharNo,
        this.active,
        this.deviceToken,
        this.createdOn,
        this.modifiedOn});

  Mrs.fromJson(Map<String, dynamic> json) {
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
    franchiseeName = json['franchisee_name'];
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
    data['franchisee_name'] = franchiseeName;
    data['is_owner'] = isOwner;
    data['aadhar_no'] = aadharNo;
    data['active'] = active;
    data['device_token'] = deviceToken;
    data['created_on'] = createdOn;
    data['modified_on'] = modifiedOn;
    return data;
  }
}