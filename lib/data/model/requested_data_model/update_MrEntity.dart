class UpdateMrEntity {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? dob;
  String? opArea;

  UpdateMrEntity({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.dob,
    this.opArea,
  });

  Map toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'address': address,
    'op_area': opArea,
    'dob': dob,
  };
}
