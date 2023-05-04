class ChangePasswordEntity{

  String? oldPassword;
  String? newPassword;

  ChangePasswordEntity({
    this.oldPassword,
    this.newPassword,
  });

  Map toJson() => {
    'oldPassword': oldPassword,
    'newPassword': newPassword,
  };

}