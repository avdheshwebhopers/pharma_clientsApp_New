class FirmEntity {
  String? id;
  String? name;
  String? phone;
  String? email;
  String? district;
  String? state;
  String? address;
  String? gst_number;
  String? drug_license;
  String? aadhaar_card;
  String? bank_name;
  String? bank_ifsc;
  String? bank_acc_no;
  String? bank_payee_name;
  List<String>? divisions;

  FirmEntity({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.district,
    this.state,
    this.address,
    this.gst_number,
    this.drug_license,
    this.aadhaar_card,
    this.bank_name,
    this.bank_ifsc,
    this.bank_acc_no,
    this.bank_payee_name,
    this.divisions,
  });

  Map toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'email': email,
    'district': district,
    'state': state,
    'address': address,
    'gst_number': gst_number,
    'drug_license': drug_license,
    'aadhaar_card': aadhaar_card,
    'bank_name': bank_name,
    'bank_ifsc': bank_ifsc,
    'bank_acc_no': bank_acc_no,
    'bank_payee_name': bank_payee_name,
    'divisions': divisions,
  };
}
