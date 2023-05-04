class ProductResponseModel {
  bool? success;
  String? message;
  List<Products>? data;

  ProductResponseModel({this.success, this.message, this.data});

  ProductResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Products>[];
      json['data'].forEach((v) {
        data!.add(Products.fromJson(v));
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

class Products {
  String? id;
  String? name;
  double? price;
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
  List<PackingVarient>? packingVarient;
  int? packingQty;
  String? packing;
  String? packingType;
  bool? upcoming;
  String? sku;
  String? hsnCode;
  String? createdOn;
  String? modifiedOn;
  bool? favourite;

  Products(
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
        this.packingVarient,
        this.packingQty,
        this.packing,
        this.packingType,
        this.upcoming,
        this.sku,
        this.hsnCode,
        this.createdOn,
        this.modifiedOn,
        this.favourite
      });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'].toDouble();
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
    if (json['packingVarient'] != null) {
      packingVarient = <PackingVarient>[];
      json['packingVarient'].forEach((v) {
        packingVarient!.add(PackingVarient.fromJson(v));
      });
    }
    packingQty = json['packing_qty'];
    packing = json['packing'];
    packingType = json['packing_type'];
    upcoming = json['upcoming'];
    sku = json['sku'];
    hsnCode = json['hsn_code'];
    createdOn = json['created_on'];
    modifiedOn = json['modified_on'];
    favourite = json['favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price?.toDouble();
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
    if (packingVarient != null) {
      data['packingVarient'] =
          packingVarient!.map((v) => v.toJson()).toList();
    }
    data['packing_qty'] = packingQty;
    data['packing'] = packing;
    data['packing_type'] = packingType;
    data['upcoming'] = upcoming;
    data['sku'] = sku;
    data['hsn_code'] = hsnCode;
    data['created_on'] = createdOn;
    data['modified_on'] = modifiedOn;
    data['favourite'] = favourite;
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

class PackingVarient {
  PackingType? packingType;
  String? packing;
  int? packingQty;
  double? price;

  PackingVarient({this.packingType, this.packing, this.packingQty, this.price});

  PackingVarient.fromJson(Map<String, dynamic> json) {
    packingType = json['packing_type'] != null
        ? PackingType.fromJson(json['packing_type'])
        : null;
    packing = json['packing'];
    packingQty = json['packing_qty'];
    price = json['price'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (packingType != null) {
      data['packing_type'] = packingType!.toJson();
    }
    data['packing'] = packing;
    data['packing_qty'] = packingQty;
    data['price'] = price?.toDouble();
    return data;
  }
}

class PackingType {
  String? value;
  String? label;

  PackingType({this.value, this.label});

  PackingType.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['label'] = label;
    return data;
  }
}