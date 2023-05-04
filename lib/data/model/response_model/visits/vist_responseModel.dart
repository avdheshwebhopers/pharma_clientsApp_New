class VisitResponseModel {
  bool? success;
  String? message;
  List<Data>? data;

  VisitResponseModel({this.success, this.message, this.data});

  VisitResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? customerId;
  String? customerName;
  String? customerEmail;
  int? customerPhone;
  String? customerProfession;
  List<Product>? products;
  String? place;
  String? remark;
  String? time;
  String? latitude;
  String? longitude;
  String? createdOn;

  Data(
      {this.id,
        this.customerId,
        this.customerName,
        this.customerEmail,
        this.customerPhone,
        this.customerProfession,
        this.products,
        this.place,
        this.remark,
        this.time,
        this.latitude,
        this.longitude,
        this.createdOn});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    customerEmail = json['customer_email'];
    customerPhone = json['customer_phone'];
    customerProfession = json['customer_profession'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
    place = json['place'];
    remark = json['remark'];
    time = json['time'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['customer_name'] = customerName;
    data['customer_email'] = customerEmail;
    data['customer_phone'] = customerPhone;
    data['customer_profession'] = customerProfession;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['place'] = place;
    data['remark'] = remark;
    data['time'] = time;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['created_on'] = createdOn;
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
  String? technicalDetail;
  int? minOrderQty;
  String? divisionId;
  String? divisionName;
  String? typeId;
  String? typeName;
  String? categoryId;
  String? categoryName;
  bool? active;
  bool? newLaunched;
  bool? upcoming;
  int? packingQty;
  String? packing;
  String? sku;
  String? hsnCode;
  String? packingType;
  String? createdOn;
  String? modifiedOn;

  Product(
      {this.id,
        this.name,
        this.price,
        this.description,
        this.details,
        this.images,
        this.technicalDetail,
        this.minOrderQty,
        this.divisionId,
        this.divisionName,
        this.typeId,
        this.typeName,
        this.categoryId,
        this.categoryName,
        this.active,
        this.newLaunched,
        this.upcoming,
        this.packingQty,
        this.packing,
        this.sku,
        this.hsnCode,
        this.packingType,
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
    technicalDetail = json['technical_detail'];
    minOrderQty = json['min_order_qty'];
    divisionId = json['division_id'];
    divisionName = json['division_name'];
    typeId = json['type_id'];
    typeName = json['type_name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    active = json['active'];
    newLaunched = json['new_launched'];
    upcoming = json['upcoming'];
    packingQty = json['packing_qty'];
    packing = json['packing'];
    sku = json['sku'];
    hsnCode = json['hsn_code'];
    packingType = json['packing_type'];
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
    data['technical_detail'] = technicalDetail;
    data['min_order_qty'] = minOrderQty;
    data['division_id'] = divisionId;
    data['division_name'] = divisionName;
    data['type_id'] = typeId;
    data['type_name'] = typeName;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['active'] = active;
    data['new_launched'] = newLaunched;
    data['upcoming'] = upcoming;
    data['packing_qty'] = packingQty;
    data['packing'] = packing;
    data['sku'] = sku;
    data['hsn_code'] = hsnCode;
    data['packing_type'] = packingType;
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