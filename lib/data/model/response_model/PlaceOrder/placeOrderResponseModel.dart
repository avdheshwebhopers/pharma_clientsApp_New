class PlaceOrderResponseModel {
  bool? success;
  String? message;
  Data? data;

  PlaceOrderResponseModel({this.success, this.message, this.data});

  PlaceOrderResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? customerId;
  String? repId;
  String? franchiseeId;
  List<Orderlist>? orderlist;
  String? createdOn;
  String? sId;

  Data(
      {this.customerId,
        this.repId,
        this.franchiseeId,
        this.orderlist,
        this.createdOn,
        this.sId});

  Data.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    repId = json['rep_id'];
    franchiseeId = json['franchisee_id'];
    if (json['orderlist'] != null) {
      orderlist = <Orderlist>[];
      json['orderlist'].forEach((v) {
        orderlist!.add(Orderlist.fromJson(v));
      });
    }
    createdOn = json['created_on'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_id'] = customerId;
    data['rep_id'] = repId;
    data['franchisee_id'] = franchiseeId;
    if (orderlist != null) {
      data['orderlist'] = orderlist!.map((v) => v.toJson()).toList();
    }
    data['created_on'] = createdOn;
    data['_id'] = sId;
    return data;
  }
}

class Orderlist {
  String? packingType;
  String? packing;
  String? sId;
  String? productId;
  int? quantity;

  Orderlist(
      {this.packingType,
        this.packing,
        this.sId,
        this.productId,
        this.quantity});

  Orderlist.fromJson(Map<String, dynamic> json) {
    packingType = json['packing_type'];
    packing = json['packing'];
    sId = json['_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['packing_type'] = packingType;
    data['packing'] = packing;
    data['_id'] = sId;
    data['product_id'] = productId;
    data['quantity'] = quantity;
    return data;
  }
}