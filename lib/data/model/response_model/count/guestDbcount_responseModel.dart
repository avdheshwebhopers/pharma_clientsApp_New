
class GuestDbCountResponseModel {
  bool? success;
  String? message;
  DbCount? data;

  GuestDbCountResponseModel({this.success, this.message, this.data});

  GuestDbCountResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? DbCount.fromJson(json['data']) : null;
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

class DbCount {
  int? productCount;
  int? launchesCount;
  int? visualaidsCount;
  int? upcommingCount;

  DbCount(
      {this.productCount,
        this.launchesCount,
        this.visualaidsCount,
        this.upcommingCount});

  DbCount.fromJson(Map<String, dynamic> json) {
    productCount = json['product_count'];
    launchesCount = json['launches_count'];
    visualaidsCount = json['visualaids_count'];
    upcommingCount = json['upcomming_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_count'] = productCount;
    data['launches_count'] = launchesCount;
    data['visualaids_count'] = visualaidsCount;
    data['upcomming_count'] = upcommingCount;
    return data;
  }
}