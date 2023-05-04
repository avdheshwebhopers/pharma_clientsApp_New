class AddToFavEntity {
  List<String>? id;

  AddToFavEntity({
   this.id
  });

  Map toJson() => {
    'products': id,
  };
}
