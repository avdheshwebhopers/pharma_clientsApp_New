

class EnquiryEntity{

  String? name;
  String? email;
  String? phone;
  String? message;

  EnquiryEntity({
    this.name,
    this.email,
    this.phone,
    this.message
  });

  Map toJson() => {
    'name': name,
    'email': email,
    'phone': phone,
    'message': message,
  };

}