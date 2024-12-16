class MainNotificationModel {
  MainNotificationModel({
    required this.type,
    this.payload,
  });

  final String type;
  final Map<String, dynamic>? payload;

  factory MainNotificationModel.fromMap(Map<String, dynamic> json) =>
      MainNotificationModel(
        type: json["type"],
        payload: json["payload"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "payload": payload,
      };
}
