class BotModel {
  BotModel({
    required this.id,
    required this.displayName,
    required this.userName,
    required this.image,
  });

  final String? id;
  final String? displayName;
  final String? userName;
  final String? image;

  factory BotModel.fromJson(Map<String, dynamic> json) {
    return BotModel(
      id: json["id"],
      displayName: json["displayName"],
      userName: json["userName"],
      image: json["image"],
    );
  }

  @override
  String toString() {
    return "$id, $displayName, $userName, $image";
  }
}
