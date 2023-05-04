class OfferResponseModel {
  bool? success;
  String? message;
  List<Data>? data;

  OfferResponseModel({this.success, this.message, this.data});

  OfferResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  String? id;
  String? title;
  String? description;
  List<Reps>? reps;
  List<Division>? division;
  String? image;
  List<String>? images;
  String? createdOn;
  String? validUpto;

  Data(
      {this.id,
        this.title,
        this.description,
        this.reps,
        this.division,
        this.image,
        this.images,
        this.createdOn,
        this.validUpto});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    if (json['reps'] != null) {
      reps = <Reps>[];
      json['reps'].forEach((v) {
        reps!.add(Reps.fromJson(v));
      });
    }
    if (json['division'] != null) {
      division = <Division>[];
      json['division'].forEach((v) {
        division!.add(Division.fromJson(v));
      });
    }
    image = json['image'];
    images = json['images'].cast<String>();
    createdOn = json['created_on'];
    validUpto = json['valid_upto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    if (reps != null) {
      data['reps'] = reps!.map((v) => v.toJson()).toList();
    }
    if (division != null) {
      data['division'] = division!.map((v) => v.toJson()).toList();
    }
    data['image'] = image;
    data['images'] = images;
    data['created_on'] = createdOn;
    data['valid_upto'] = validUpto;
    return data;
  }
}

class Reps {
  String? id;
  String? name;

  Reps({this.id, this.name});

  Reps.fromJson(Map<String, dynamic> json) {
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

class Division {
  String? id;
  String? name;

  Division({this.id, this.name});

  Division.fromJson(Map<String, dynamic> json) {
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