class CallNotificationModel {
  CallNotificationModel({
    required this.withVideo,
    required this.token,
    required this.channel,
    required this.name,
    required this.isGroup,
  });

  final bool withVideo;
  final String token;
  final String channel;
  final String name;
  final bool isGroup;

  factory CallNotificationModel.fromMap(Map<String, dynamic> json) =>
      CallNotificationModel(
        withVideo: json["with_video"] ?? false,
        token: json["token"] ?? false,
        channel: json["channel"] ?? false,
        name: json["name"] ?? false,
        isGroup: json["isGroup"] ?? false,
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> json = {};
    json["with_video"] = withVideo;
    json["token"] = token;
    json["channel"] = channel;
    json["name"] = name;
    json["isGroup"] = isGroup;
    return json;
  }
}
