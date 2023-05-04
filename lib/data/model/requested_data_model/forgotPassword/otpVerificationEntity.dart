class OtpVerificationEntity {
  String? id;
  String? otp;

  OtpVerificationEntity({
    this.id,
    this.otp
  });

  Map toJson() => {
    'id': id,
    'otp':otp,
  };
}