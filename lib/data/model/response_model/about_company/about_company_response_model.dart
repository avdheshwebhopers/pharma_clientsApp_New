class AboutCompanyResponseModel {
  bool? success;
  String? message;
  AboutCompany? data;

  AboutCompanyResponseModel({this.success, this.message, this.data});

  AboutCompanyResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? AboutCompany.fromJson(json['data']) : null;
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

class AboutCompany {
  String? appLiveLink;
  String? iosAppLiveLink;
  String? id;
  String? phone;
  String? whatsapp;
  String? website;
  String? email;
  String? about;
  String? address;
  String? address2;
  String? address3;
  String? address4;
  String? facebook;
  String? twitter;
  String? pinterest;
  String? linkedin;
  String? corporateVideo;
  String? whatsappGreeting;
  List<DownloadLinks>? downloadLinks;
  List<String>? aboutImgs;
  String? aboutImg;
  String? createdOn;
  String? modifiedOn;
  List<Certificates>? certificates;

  AboutCompany(
      {this.appLiveLink,
        this.iosAppLiveLink,
        this.id,
        this.phone,
        this.whatsapp,
        this.website,
        this.email,
        this.about,
        this.address,
        this.address2,
        this.address3,
        this.address4,
        this.facebook,
        this.twitter,
        this.pinterest,
        this.linkedin,
        this.corporateVideo,
        this.whatsappGreeting,
        this.downloadLinks,
        this.aboutImgs,
        this.aboutImg,
        this.createdOn,
        this.modifiedOn,
        this.certificates});

  AboutCompany.fromJson(Map<String, dynamic> json) {
    appLiveLink = json['app_live_link'];
    iosAppLiveLink = json['ios_app_live_link'];
    id = json['id'];
    phone = json['phone'];
    whatsapp = json['whatsapp'];
    website = json['website'];
    email = json['email'];
    about = json['about'];
    address = json['address'];
    address2 = json['address2'];
    address3 = json['address3'];
    address4 = json['address4'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    pinterest = json['pinterest'];
    linkedin = json['linkedin'];
    corporateVideo = json['corporate_video'];
    whatsappGreeting = json['whatsapp_greeting'];
    if (json['download_links'] != null) {
      downloadLinks = <DownloadLinks>[];
      json['download_links'].forEach((v) {
        downloadLinks!.add(DownloadLinks.fromJson(v));
      });
    }
    aboutImgs = json['about_imgs'].cast<String>();
    aboutImg = json['about_img'];
    createdOn = json['created_on'];
    modifiedOn = json['modified_on'];
    if (json['certificates'] != null) {
      certificates = <Certificates>[];
      json['certificates'].forEach((v) {
        certificates!.add(Certificates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['app_live_link'] = appLiveLink;
    data['ios_app_live_link'] = iosAppLiveLink;
    data['id'] = id;
    data['phone'] = phone;
    data['whatsapp'] = whatsapp;
    data['website'] = website;
    data['email'] = email;
    data['about'] = about;
    data['address'] = address;
    data['address2'] = address2;
    data['address3'] = address3;
    data['address4'] = address4;
    data['facebook'] = facebook;
    data['twitter'] = twitter;
    data['pinterest'] = pinterest;
    data['linkedin'] = linkedin;
    data['corporate_video'] = corporateVideo;
    data['whatsapp_greeting'] = whatsappGreeting;
    if (downloadLinks != null) {
      data['download_links'] =
          downloadLinks!.map((v) => v.toJson()).toList();
    }
    data['about_imgs'] = aboutImgs;
    data['about_img'] = aboutImg;
    data['created_on'] = createdOn;
    data['modified_on'] = modifiedOn;
    if (certificates != null) {
      data['certificates'] = certificates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DownloadLinks {
  String? divisionId;
  String? divisionName;
  String? divisionEmail;
  String? divisionPhone;
  String? divisionAddress;
  bool? divisionActive;
  String? productListLink;
  String? visualaidsLink;

  DownloadLinks(
      {this.divisionId,
        this.divisionName,
        this.divisionEmail,
        this.divisionPhone,
        this.divisionAddress,
        this.divisionActive,
        this.productListLink,
        this.visualaidsLink});

  DownloadLinks.fromJson(Map<String, dynamic> json) {
    divisionId = json['division_id'];
    divisionName = json['division_name'];
    divisionEmail = json['division_email'];
    divisionPhone = json['division_phone'];
    divisionAddress = json['division_address'];
    divisionActive = json['division_active'];
    productListLink = json['product_list_link'];
    visualaidsLink = json['visualaids_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['division_id'] = divisionId;
    data['division_name'] = divisionName;
    data['division_email'] = divisionEmail;
    data['division_phone'] = divisionPhone;
    data['division_address'] = divisionAddress;
    data['division_active'] = divisionActive;
    data['product_list_link'] = productListLink;
    data['visualaids_link'] = visualaidsLink;
    return data;
  }
}
class Certificates {
  String? id;
  String? title;
  String? description;
  String? image;
  String? createdOn;
  String? modifiedOn;

  Certificates(
      {this.id,
        this.title,
        this.description,
        this.image,
        this.createdOn,
        this.modifiedOn});

  Certificates.fromJson(Map<String, dynamic> json) {
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