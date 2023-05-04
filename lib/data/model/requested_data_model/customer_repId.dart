class CustomerRepId {
  String? id;
  CustomerRepId({this.id});

  Map toJson() => {
    'rep_id': id,
  };
}