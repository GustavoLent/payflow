import 'dart:convert';

class UserModel {
  final String name;
  final String photoURL;

  UserModel(this.name, this.photoURL);

  factory UserModel.fromMap(Map<String, dynamic> userAsMap) {
    return UserModel(userAsMap['name'], userAsMap['photoURL']);
  }

  factory UserModel.fromJson(String userAsJson) {
    final userAsMap = json.decode(userAsJson);
    return UserModel.fromMap(userAsMap);
  }

  Map<String, String> toMap() {
    Map<String, String> userAsMap = {"name": name, "photoURL": photoURL};
    return userAsMap;
  }

  String toJson() {
    Map<String, String> userAsMap = this.toMap();
    String userAsJson = jsonEncode(userAsMap);
    return userAsJson;
  }
}
