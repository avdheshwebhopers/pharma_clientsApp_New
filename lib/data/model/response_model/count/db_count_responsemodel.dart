class DashBoardCountResponseModel {
  bool? success;
  String? message;
  Count? data;

  DashBoardCountResponseModel({this.success, this.message, this.data});

  DashBoardCountResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Count.fromJson(json['data']) : null;
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

class Count {
  int? productCount;
  int? launchesCount;
  int? visualaidsCount;
  int? favouriteProductCount;
  int? offerCount;
  int? mrCount;
  int? companyOrderCount;
  int? orderCount;
  int? upcommingCount;

  Count(
      {this.productCount,
        this.launchesCount,
        this.visualaidsCount,
        this.favouriteProductCount,
        this.offerCount,
        this.mrCount,
        this.companyOrderCount,
        this.orderCount,
        this.upcommingCount});

  Count.fromJson(Map<String, dynamic> json) {
    productCount = json['product_count'];
    launchesCount = json['launches_count'];
    visualaidsCount = json['visualaids_count'];
    favouriteProductCount = json['favourite_product_count'];
    offerCount = json['offer_count'];
    mrCount = json['mr_count'];
    companyOrderCount = json['company_order_count'];
    orderCount = json['order_count'];
    upcommingCount = json['upcomming_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_count'] = productCount;
    data['launches_count'] = launchesCount;
    data['visualaids_count'] = visualaidsCount;
    data['favourite_product_count'] = favouriteProductCount;
    data['offer_count'] = offerCount;
    data['mr_count'] = mrCount;
    data['company_order_count'] = companyOrderCount;
    data['order_count'] = orderCount;
    data['upcomming_count'] = upcommingCount;
    return data;
  }
}