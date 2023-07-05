class CompanyOrderResponseModel {
  bool? success;
  String? message;
  List<Data>? data;

  CompanyOrderResponseModel({this.success, this.message, this.data});

  CompanyOrderResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? repId;
  String? repName;
  String? createdOn;
  List<Orderlist>? orderlist;

  Data({this.id, this.repId, this.repName, this.createdOn, this.orderlist});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    repId = json['rep_id'];
    repName = json['rep_name'];
    createdOn = json['created_on'];
    if (json['orderlist'] != null) {
      orderlist = <Orderlist>[];
      json['orderlist'].forEach((v) {
        orderlist!.add(Orderlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rep_id'] = repId;
    data['rep_name'] = repName;
    data['created_on'] = createdOn;
    if (orderlist != null) {
      data['orderlist'] = orderlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orderlist {
  Product? product;
  int? price;
  int? quantity;
  String? packingType;

  Orderlist({this.product, this.quantity, this.packingType,this.price});

  Orderlist.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
    price = json['price'];
    quantity = json['quantity'];
    packingType = json['packing_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['price'] = this.price;
    data['quantity'] = quantity;
    data['packing_type'] = packingType;
    return data;
  }
}

class Product {
  String? id;
  String? name;
  int? price;
  String? description;
  String? details;
  List<Images>? images;
  int? minOrderQty;
  String? divisionId;
  String? divisionName;
  String? typeId;
  String? typeName;
  String? categoryId;
  String? categoryName;
  String? createdOn;
  String? modifiedOn;

  Product(
      {this.id,
        this.name,
        this.price,
        this.description,
        this.details,
        this.images,
        this.minOrderQty,
        this.divisionId,
        this.divisionName,
        this.typeId,
        this.typeName,
        this.categoryId,
        this.categoryName,
        this.createdOn,
        this.modifiedOn});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    details = json['details'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    minOrderQty = json['min_order_qty'];
    divisionId = json['division_id'];
    divisionName = json['division_name'];
    typeId = json['type_id'];
    typeName = json['type_name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    createdOn = json['created_on'];
    modifiedOn = json['modified_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['description'] = description;
    data['details'] = details;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['min_order_qty'] = minOrderQty;
    data['division_id'] = divisionId;
    data['division_name'] = divisionName;
    data['type_id'] = typeId;
    data['type_name'] = typeName;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['created_on'] = createdOn;
    data['modified_on'] = modifiedOn;
    return data;
  }
}

class Images {
  String? type;
  String? url;

  Images({this.type, this.url});

  Images.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['url'] = url;
    return data;
  }
}