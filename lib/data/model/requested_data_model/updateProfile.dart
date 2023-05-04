class UpdateProfile {
  String? name;
  String? email;
  String? phone;
  String? aaddhar;
  String? address;
  String? city;
  String? state;
  String? op_area;
  String? dob;

  UpdateProfile(
      {this.name,
        this.email,
        this.phone,
        this.aaddhar,
        this.dob,
        this.op_area,
        this.address,
        this.state,
        this.city});

  Map toJson() => {
    'name': name,
    'email': email,
    'phone': phone,
    'address': address,
    'city': city,
    'state': state,
    'op_area': op_area,
    'dob': dob,
    'aadhar_no': aaddhar
  };
}