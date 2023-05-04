class CartEntity {
  final String id;
  final String name;
  final double price;
  final String packing;
  final String packingType;
  int quantity;

  CartEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.packing,
    required this.packingType,
    this.quantity = 1,
  });

  CartEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        price = json['price'],
        packing = json['packing'],
        packingType = json['packingType'],
        quantity = json['quantity'];

  Map<String, dynamic> toJson() => {
      'id': id,
      'name': name,
      'price': price,
      'packing': packing,
      'packingType': packingType,
      'quantity': quantity,
    };
}
