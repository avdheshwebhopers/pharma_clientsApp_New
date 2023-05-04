class AddMrEntity {
  String? name;
  String? email;
  String? phone;
  String? dob;
  String? op_area;
  String? address;
  String? state;
  String? city;
  String? password;

  AddMrEntity(
      {this.name,
        this.email,
        this.phone,
        this.dob,
        this.op_area,
        this.address,
        this.state,
        this.city,
        this.password
      });

  Map toJson() => {
    'name': name,
    'email': email,
    'phone': phone,
    'dob': dob,
    'op_area': op_area,
    'address': address,
    'state': state,
    'city': city,
    'password': password,
  };
}