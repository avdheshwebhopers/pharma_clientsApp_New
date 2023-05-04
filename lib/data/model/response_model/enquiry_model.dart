class EnquiryResponseModel {
  bool? success;
  String? message;
  String? data;

  EnquiryResponseModel({this.success, this.message, this.data});

  EnquiryResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}