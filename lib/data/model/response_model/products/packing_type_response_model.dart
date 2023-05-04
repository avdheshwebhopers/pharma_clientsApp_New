class PackingTypeResponseModel {
  bool? success;
  String? message;
  List<PackingType>? data;

  PackingTypeResponseModel({this.success, this.message, this.data});

  PackingTypeResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PackingType>[];
      json['data'].forEach((v) {
        data!.add(PackingType.fromJson(v));
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

class PackingType {
  String? id;
  String? name;

  PackingType({this.id, this.name});

  PackingType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}