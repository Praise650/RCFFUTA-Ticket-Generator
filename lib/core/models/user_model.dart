class UserModel {
  String name;
  String avatarUrl;
  String userId;
  UserModel({
    required this.name,
    required this.avatarUrl,
    required this.userId
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'avatarUrl': avatarUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['login'] as String,
      avatarUrl: map['avatar_url'] as String,
      userId: map['userId'] ?? "ayodel65142",
    );
  }
}
