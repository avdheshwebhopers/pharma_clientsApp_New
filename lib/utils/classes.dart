
class OrderWithQuanity {
  int? quanity;
  String? name;
  String? packing;

  OrderWithQuanity({
    this.quanity,
    this.name,
    this.packing
  });



  @override
  String toString() {
    return "$quanity x $name ";
  }
  String? getPacking(){
    return "$packing\n";
  }
}