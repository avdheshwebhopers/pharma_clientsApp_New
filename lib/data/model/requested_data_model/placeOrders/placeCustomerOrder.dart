class PlaceCustomerOrder{
  String? customerId;
  List<Orders>? orderList;


  PlaceCustomerOrder(
  {
  this.customerId,
    this.orderList,
  });


  Map toJson() => {
  'orderlist': orderList,
  'customer_id': customerId
  };
}

class Orders {
  String? productId;
  int? quantity;
  String? packingType;
  String? packing;
  int? price;

  Orders({
    this.productId,
    this.quantity,
    this.price,
    this.packing,
    this.packingType
  });

  Map toJson() => {
    "product_id": productId,
    "quantity": quantity,
    "packing_type": packingType,
    "price": price,
    "packing": packing
  };

}