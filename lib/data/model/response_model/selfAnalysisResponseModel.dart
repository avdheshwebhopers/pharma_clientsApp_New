class SelfAnalysisResponseModel {
  bool? success;
  String? message;
  Data? data;

  SelfAnalysisResponseModel({this.success, this.message, this.data});

  SelfAnalysisResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  List<CustomerView>? customerView;
  List<MrView>? mrView;

  Data({this.customerView, this.mrView});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['customer_view'] != null) {
      customerView = <CustomerView>[];
      json['customer_view'].forEach((v) {
        customerView!.add(CustomerView.fromJson(v));
      });
    }
    if (json['mr_view'] != null) {
      mrView = <MrView>[];
      json['mr_view'].forEach((v) {
        mrView!.add(MrView.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customerView != null) {
      data['customer_view'] =
          customerView!.map((v) => v.toJson()).toList();
    }
    if (mrView != null) {
      data['mr_view'] = mrView!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerView {
  CustomerInfo? customerInfo;
  int? customerToMrCount;
  List<Mrs>? mrs;

  CustomerView({this.customerInfo, this.customerToMrCount, this.mrs});

  CustomerView.fromJson(Map<String, dynamic> json) {
    customerInfo = json['customer_info'] != null
        ? CustomerInfo.fromJson(json['customer_info'])
        : null;
    customerToMrCount = json['customer_to_mr_count'];
    if (json['mrs'] != null) {
      mrs = <Mrs>[];
      json['mrs'].forEach((v) {
        mrs!.add(Mrs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customerInfo != null) {
      data['customer_info'] = customerInfo!.toJson();
    }
    data['customer_to_mr_count'] = customerToMrCount;
    if (mrs != null) {
      data['mrs'] = mrs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerInfo {
  String? id;
  String? name;
  int? phone;
  String? email;
  String? profession;
  String? workingPlace;

  CustomerInfo(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.profession,
        this.workingPlace});

  CustomerInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    profession = json['profession'];
    workingPlace = json['working_place'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['profession'] = profession;
    data['working_place'] = workingPlace;
    return data;
  }
}

class Mrs {
  MrInfo? mrInfo;
  int? mrToCustomerVisitCount;
  int? productsCount;
  List<visitProducts>? products;
  List<DataByVisit>? dataByVisit;

  Mrs(
      {this.mrInfo,
        this.mrToCustomerVisitCount,
        this.productsCount,
        this.products,
        this.dataByVisit});

  Mrs.fromJson(Map<String, dynamic> json) {
    mrInfo =
    json['mr_info'] != null ? MrInfo.fromJson(json['mr_info']) : null;
    mrToCustomerVisitCount = json['mr_to_customer_visit_count'];
    productsCount = json['products_count'];
    if (json['products'] != null) {
      products = <visitProducts>[];
      json['products'].forEach((v) {
        products!.add(visitProducts.fromJson(v));
      });
    }
    if (json['data_by_visit'] != null) {
      dataByVisit = <DataByVisit>[];
      json['data_by_visit'].forEach((v) {
        dataByVisit!.add(DataByVisit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mrInfo != null) {
      data['mr_info'] = mrInfo!.toJson();
    }
    data['mr_to_customer_visit_count'] = mrToCustomerVisitCount;
    data['products_count'] = productsCount;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (dataByVisit != null) {
      data['data_by_visit'] = dataByVisit!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MrInfo {
  String? id;
  String? name;
  String? phone;
  String? opArea;

  MrInfo({this.id, this.name, this.phone, this.opArea});

  MrInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    opArea = json['op_area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['op_area'] = opArea;
    return data;
  }
}

class visitProducts {
  String? id;
  String? name;
  String? description;
  String? divisionName;
  String? typeName;
  String? categoryName;
  int? count;

  visitProducts(
      {this.id,
        this.name,
        this.description,
        this.divisionName,
        this.typeName,
        this.categoryName,
        this.count});

  visitProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    divisionName = json['division_name'];
    typeName = json['type_name'];
    categoryName = json['category_name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['division_name'] = divisionName;
    data['type_name'] = typeName;
    data['category_name'] = categoryName;
    data['count'] = count;
    return data;
  }
}

class DataByVisit {
  String? id;
  List<visitProducts>? products;
  String? place;
  String? remark;
  String? time;
  String? latitude;
  String? longitude;
  String? createdOn;

  DataByVisit(
      {this.id,
        this.products,
        this.place,
        this.remark,
        this.time,
        this.latitude,
        this.longitude,
        this.createdOn});

  DataByVisit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['products'] != null) {
      products = <visitProducts>[];
      json['products'].forEach((v) {
        products!.add(visitProducts.fromJson(v));
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

class MrView {
  MrInfo? mrInfo;
  int? mrToCustomerVisitCount;
  List<Customers>? customers;

  MrView({this.mrInfo, this.mrToCustomerVisitCount, this.customers});

  MrView.fromJson(Map<String, dynamic> json) {
    mrInfo =
    json['mr_info'] != null ? MrInfo.fromJson(json['mr_info']) : null;
    mrToCustomerVisitCount = json['mr_to_customer_visit_count'];
    if (json['customers'] != null) {
      customers = <Customers>[];
      json['customers'].forEach((v) {
        customers!.add(Customers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mrInfo != null) {
      data['mr_info'] = mrInfo!.toJson();
    }
    data['mr_to_customer_visit_count'] = mrToCustomerVisitCount;
    if (customers != null) {
      data['customers'] = customers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customers {
  CustomerInfo? customerInfo;
  int? visitsCount;
  int? productsCount;
  List<visitProducts>? products;
  List<DataByVisit>? dataByVisit;

  Customers(
      {this.customerInfo,
        this.visitsCount,
        this.productsCount,
        this.products,
        this.dataByVisit});

  Customers.fromJson(Map<String, dynamic> json) {
    customerInfo = json['customer_info'] != null
        ? CustomerInfo.fromJson(json['customer_info'])
        : null;
    visitsCount = json['visits_count'];
    productsCount = json['products_count'];
    if (json['products'] != null) {
      products = <visitProducts>[];
      json['products'].forEach((v) {
        products!.add(visitProducts.fromJson(v));
      });
    }
    if (json['data_by_visit'] != null) {
      dataByVisit = <DataByVisit>[];
      json['data_by_visit'].forEach((v) {
        dataByVisit!.add(DataByVisit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customerInfo != null) {
      data['customer_info'] = customerInfo!.toJson();
    }
    data['visits_count'] = visitsCount;
    data['products_count'] = productsCount;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (dataByVisit != null) {
      data['data_by_visit'] = dataByVisit!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}