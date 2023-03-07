import 'dart:convert';

ConfigModel configModelFromJson(String str) => ConfigModel.fromJson(json.decode(str));

String configModelToJson(ConfigModel data) => json.encode(data.toJson());

ConfigModel configModelFromJsonWithDecode(Map<String, dynamic> json) => ConfigModel.fromJson(json);

class ConfigModel {
  ConfigModel({
    required this.key,
    required this.value,
  });

  String key;
  List<String> value;

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
    key: json["key"],
    value: List<String>.from(json["value"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": List<dynamic>.from(value.map((x) => x)),
  };
}
