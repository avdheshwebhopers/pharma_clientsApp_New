class PlaceDistributorOrder{
  List<Order>? orderList;

  PlaceDistributorOrder(
      {
        this.orderList,
      });


  Map toJson() => {
    'orderlist': orderList,
  };
}

class Order {
  String? productId;
  int? quantity;
  String? packingType;
  String? packing;
  int? price;

  Order({
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