class AddVisitEntity {
  String? latitude;
  String? longitude;
  List<String>? products;
  String? customerId;
  String? place;
  String? remark;
  String? time;
  String? repId;
  String? sId;

  AddVisitEntity({
    this.latitude,
    this.longitude,
    this.products,
    this.customerId,
    this.place,
    this.remark,
    this.time,
    this.repId,
    this.sId
  });

  Map toJson() =>
      {
        "customer_id": customerId,
        "place": place,
        "remark": remark,
        "time": time,
        "products": products,
        "latitude": latitude,
        "longitude": longitude
      };
}