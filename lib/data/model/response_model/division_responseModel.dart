class DivisionResponseModel {
  bool? success;
  String? message;
  List<Data>? data;

  DivisionResponseModel({this.success, this.message, this.data});

  DivisionResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  bool? active;
  String? createdOn;
  String? modifiedOn;
  String? productListLink;
  String? visualaidsLink;

  Data(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.address,
        this.active,
        this.createdOn,
        this.modifiedOn,
        this.productListLink,
        this.visualaidsLink});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    active = json['active'];
    createdOn = json['created_on'];
    modifiedOn = json['modified_on'];
    productListLink = json['product_list_link'];
    visualaidsLink = json['visualaids_link'];
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
    data['product_list_link'] = productListLink;
    data['visualaids_link'] = visualaidsLink;
    return data;
  }
}