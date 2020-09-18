import 'dart:convert';

class TelegramAccountModel {
  final int tg_user_id;
  final String phone;
  final String first_name;
  final String last_name;
  final String username;
  final String small_img_path;
  final bool activ;

  TelegramAccountModel({
    this.tg_user_id,
    this.phone,
    this.first_name,
    this.last_name,
    this.username,
    this.small_img_path,
    this.activ,
  });

  factory TelegramAccountModel.fromJson(Map<String, dynamic> parsedJson) {
    return TelegramAccountModel(
      tg_user_id: parsedJson['tg_user_id'],
      phone: parsedJson['phone'],
      first_name: parsedJson['first_name'],
      last_name: parsedJson['last_name'],
      username: parsedJson['username'],
      activ: parsedJson['activ'],
    );
  }
}

List<TelegramAccountModel> parse(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<TelegramAccountModel>((json) => TelegramAccountModel.fromJson(json))
      .toList();
}
