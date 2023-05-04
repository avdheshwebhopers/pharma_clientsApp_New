class AddVisitResponseModel {
  bool? success;
  String? message;
  VisitEntity? data;

  AddVisitResponseModel({this.success, this.message, this.data});

  AddVisitResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? VisitEntity.fromJson(json['data']) : null;
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

class VisitEntity {
  String? latitude;
  String? longitude;
  List<String>? products;
  String? customerId;
  String? place;
  String? remark;
  String? time;
  String? repId;
  String? sId;

  VisitEntity(
      {this.latitude,
        this.longitude,
        this.products,
        this.customerId,
        this.place,
        this.remark,
        this.time,
        this.repId,
        this.sId});

  VisitEntity.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    products = json['products'].cast<String>();
    customerId = json['customer_id'];
    place = json['place'];
    remark = json['remark'];
    time = json['time'];
    repId = json['rep_id'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['products'] = products;
    data['customer_id'] = customerId;
    data['place'] = place;
    data['remark'] = remark;
    data['time'] = time;
    data['rep_id'] = repId;
    data['_id'] = sId;
    return data;
  }
}