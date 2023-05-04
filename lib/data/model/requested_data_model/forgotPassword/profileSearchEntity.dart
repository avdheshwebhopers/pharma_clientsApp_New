class ProfileSearchEntity {
  String? email;

  ProfileSearchEntity({
    this.email,
  });

  Map toJson() => {
    'email': email,
  };
}