class ResetPasswordEntity {
  String? id;
  String? paasword;

  ResetPasswordEntity({
    this.id,
    this.paasword
  });

  Map toJson() => {
    'id': id,
    'password': paasword,
  };
}