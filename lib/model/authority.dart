import 'dart:convert';

Authority authorityFromJson(String str) => Authority.fromJson(json.decode(str));

String authorityToJson(Authority data) => json.encode(data.toJson());

Authority authorityFromJsonWithDecode(Map<String, dynamic> json) => Authority.fromJson(json);

class Authority {
  Authority({
    required this.email,
    required this.authorized,
  });

  String email;
  bool authorized;

  factory Authority.fromJson(Map<String, dynamic> json) => Authority(
    email: json["email"],
    authorized: json["authorized"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "authorized": authorized,
  };
}
