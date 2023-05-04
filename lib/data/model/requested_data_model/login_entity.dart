
class LoginEntity{

  String? email;
  String? password;
  String? deviceToken;

  LoginEntity({

    this.email,
    this.password,
    this.deviceToken

});

  Map toJson() => {
    'emailOrPhone': email,
    'password': password,
    'device_token': deviceToken
  };
}