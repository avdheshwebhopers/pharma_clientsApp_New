class RegisterEntity {
  String? name;
  String? email;
  String? phone;
  String? address;
  String? state;
  String? city;
  String? dob;
  String? opArea;
  String? password;
  String? firmName;
  String? gstNumber;
  String? drugLicense;
  String? aadhaarCard;
  String? firmPhone;
  String? firmEmail;
  String? firmDistrict;
  String? firmState;
  String? firmAddress;
  String? bankName;
  String? bankIfsc;
  String? bankAccNo;
  String? bankPayeeName;
  List<String>? divisions;

  RegisterEntity({
    this.name,
    this.email,
    this.phone,
    this.address,
    this.state,
    this.city,
    this.dob,
    this.opArea,
    this.password,
    this.firmName,
    this.gstNumber,
    this.drugLicense,
    this.aadhaarCard,
    this.firmPhone,
    this.firmEmail,
    this.firmDistrict,
    this.firmState,
    this.firmAddress,
    this.bankName,
    this.bankIfsc,
    this.bankAccNo,
    this.bankPayeeName,
    this.divisions,
  });

  Map toJson() => {
    'name': name,
    'email': email,
    'phone': phone,
    'address': address,
    'state': state,
    'city': city,
    'dob': dob,
    'op_area': opArea,
    'password': password,
    'firm_name': firmName,
    'gst_number': gstNumber,
    'drug_license': drugLicense,
    'aadhaar_card': aadhaarCard,
    'firm_phone': firmPhone,
    'firm_email': firmEmail,
    'firm_district': firmDistrict,
    'firm_state': firmState,
    'firm_address': firmAddress,
    'bank_name': bankName,
    'bank_ifsc': bankIfsc,
    'bank_acc_no': bankAccNo,
    'bank_payee_name': bankPayeeName,
    'divisions': divisions,
  };
}
