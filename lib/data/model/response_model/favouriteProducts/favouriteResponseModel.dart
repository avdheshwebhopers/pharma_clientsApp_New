class FavouriteResponseModel {
  bool? success;
  String? message;
  Null? data;

  FavouriteResponseModel({this.success, this.message, this.data});

  FavouriteResponseModel.fromJson(Map<String, dynamic> json) {
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