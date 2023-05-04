class AddCustomerEntity {
  String? name;
  String? phone;
  String? profession;
  String? address;
  String? state;
  String? city;
  String? email;
  String? workingPlace;
  String? dob;
  String? weddingAnniversary;

  AddCustomerEntity({
    this.name,
    this.phone,
    this.profession,
    this.address,
    this.state,
    this.city,
    this.email,
    this.workingPlace,
    this.dob,
    this.weddingAnniversary
  });

  Map toJson() => {
    'name': name,
    'phone': phone,
    'profession': profession,
    'address': address,
    'state': state,
    'city': city,
    'email': email,
    'working_place': workingPlace,
    'dob': dob,
    'wedding_anniversary': weddingAnniversary,
  };
}
