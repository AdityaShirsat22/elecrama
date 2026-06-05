class NotificationModel {
  final int notificationId;
  final String value;
  final int relatedId;
  final String createdDate;
  final String notificationStatus;

  NotificationModel({
    required this.notificationId,
    required this.value,
    required this.relatedId,
    required this.createdDate,
    required this.notificationStatus,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationId: json['NotificationId'] ?? 0,
      value: json['Value'] ?? '',
      relatedId: json['RelatedId'] ?? 0,
      createdDate: json['dtCreatedDate'] ?? '',
      notificationStatus: json['blNotifictnStatus'] ?? '0',
    );
  }
}
