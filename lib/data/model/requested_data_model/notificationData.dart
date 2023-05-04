class NotificationData {
  final String title;
  final String message;
  final String dateTime;

  NotificationData({
    required this.title,
    required this.message,
    required this.dateTime,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      title: json['title'] as String,
      message: json['message'] as String,
      dateTime: json['dateTime'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'message': message,
      'dateTime': dateTime
    };
  }
}
