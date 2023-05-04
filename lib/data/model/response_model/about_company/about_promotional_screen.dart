
class PromotionalResponseModel {
  bool? success;
  String? message;
  List<PromotionalData>? data;

  PromotionalResponseModel({this.success, this.message, this.data});

  PromotionalResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PromotionalData>[];
      json['data'].forEach((v) {
        data!.add(PromotionalData.fromJson(v));
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

class PromotionalData {
  String? id;
  String? title;
  String? description;
  String? image;
  String? createdOn;
  String? modifiedOn;

  PromotionalData(
      {this.id,
        this.title,
        this.description,
        this.image,
        this.createdOn,
        this.modifiedOn});

  PromotionalData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    createdOn = json['created_on'];
    modifiedOn = json['modified_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    data['created_on'] = createdOn;
    data['modified_on'] = modifiedOn;
    return data;
  }
}