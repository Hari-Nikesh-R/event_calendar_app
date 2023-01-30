import 'dart:convert';

UserDetail userDetailFromJson(String str) => UserDetail.fromJson(json.decode(str));

String userDetailToJson(UserDetail data) => json.encode(data.toJson());

class UserDetail {
  UserDetail({
    required this.email,
    this.profilePicture,
    required this.firstName,
    required this.lastName,
    required this.organization,
    required this.phoneNumber,
    required this.password,
    this.organizationalAddress,
    this.authority,
  });

  String email;
  String? profilePicture;
  String firstName;
  String lastName;
  String organization;
  String phoneNumber;
  String password;
  dynamic organizationalAddress;
  bool? authority;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
    email: json["email"],
    profilePicture: json["profilePicture"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    organization: json["organization"],
    phoneNumber: json["phoneNumber"],
    password: json["password"],
    organizationalAddress: json["organizationalAddress"],
    authority: json["authority"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "profilePicture": profilePicture,
    "firstName": firstName,
    "lastName": lastName,
    "organization": organization,
    "phoneNumber": phoneNumber,
    "password": password,
    "organizationalAddress": organizationalAddress,
    "authority": authority,
  };
}
