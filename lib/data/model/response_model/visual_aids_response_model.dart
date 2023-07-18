class VisualAidsResponseModel {
  bool? success;
  String? message;
  List<VisualAids>? data;

  VisualAidsResponseModel({this.success, this.message, this.data});

  VisualAidsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <VisualAids>[];
      json['data'].forEach((v) {
        data!.add(VisualAids.fromJson(v));
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

class VisualAids {
  String? name;
  String? url;
  String? division;
  String? category;

  VisualAids({this.name, this.url, this.division, this.category});

  VisualAids.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    division = json['division'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    data['division'] = division;
    data['category'] = category;
    return data;
  }
}