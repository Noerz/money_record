import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final int? idUser;
  final String? fullName;
  final String? adress;
  final String? noHp;
  final String? gender;
  final String? image;
  final int? userId;
  final String? email;
  final String? role;
  final String? accessToken;

  User({
    this.idUser,
    this.fullName,
    this.adress,
    this.noHp,
    this.gender,
    this.image,
    required this.userId,
    this.email,
    required this.role,
    required this.accessToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        idUser: json["idUser"],
        fullName: json["fullName"],
        adress: json["adress"],
        noHp: json["noHp"],
        gender: json["gender"],
        image: json["image"],
        userId: json["userId"],
        email: json["email"],
        role: json["role"],
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "fullName": fullName,
        "adress": adress,
        "noHp": noHp,
        "gender": gender,
        "image": image,
        "userId": userId,
        "email": email,
        "role": role,
        "accessToken": accessToken,
      };
}

List<User> usersFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));
