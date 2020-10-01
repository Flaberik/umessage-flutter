import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:um/models/telegram_account_model.dart' as tgModel;
import 'package:universal_html/html.dart' as html;
import 'package:http/http.dart' as http;

class ApiClient {
  static ApiClient _instance;
  static http.BaseClient client;
  int botId;

  static String access_token = "";
  static String refreshtoken = "";
  static const String protocol = "http";
  static const String site_url = protocol + "://umessage.online/";
  static const String api_url = site_url + "bot_api0/";

  static String username = "";
  static String email = "";
  static String password = "";

  static ApiClient getInstance() {
    if (ApiClient._instance == null) {
      ApiClient.client = new http.Client();

      ApiClient._instance = new ApiClient._internal();
    }
    return ApiClient._instance;
  }

  // void saveLastPageToLocalStorage(String )

  void saveDataToLocalStorage(String email, String password) {
    html.window.localStorage['email'] = email;
    html.window.localStorage['password'] = password;
    ApiClient.email = email;
    ApiClient.password = password;
  }

  void clearDataInLocalStorage() {
    html.window.localStorage['email'] = '';
    html.window.localStorage['password'] = '';
  }

  Future checkTokenAuth() async {
    access_token = html.window.localStorage['access_token'];

    if (access_token != null && access_token.length > 0) {
      ApiClient.email = html.window.localStorage['email'];
      ApiClient.password = html.window.localStorage['password'];

      var response = await client.get(api_url + 'getMe',
          headers: {'Authorization': 'Token ' + access_token});

      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body);

        if (jsonBody['status'] == 'succsess') {
          ApiClient.username = jsonBody['username'];
        }
      }
    }
  }

  ApiClient._internal();

  Future authorization(String email, String password) async {
    try {
      var response = await client.post(api_url + 'auth-user',
          body: {'email': email, 'password': password});

      print('${response.statusCode} auth_status_code');

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        username = json['user'];
        refreshtoken = json['refreshtoken'];
        access_token = json['access_token'];

        html.window.localStorage['access_token'] = access_token;
      }
    } catch (e) {
      print('authorizationEx' + e.toString());
    }
  }

  Future telegramBotAddButton(
      {int row, int col, String text, int messageId}) async {
    // telegram-bot-button
    try {
      var response =
          await client.post(api_url + 'telegram-bot-button/', headers: {
        'Authorization': 'Token ' + access_token
      }, body: {
        'row': row.toString(),
        'col': col.toString(),
        'text': text,
        'messageId': messageId.toString()
      });
      print('${response.statusCode}, ${response.body}');
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
        if (jsonBody['status'] == 'done') {
          return jsonBody['messages'];
        }
      }
    } catch (e) {
      print('telegramBotAddButton excep: $e');
    }
    return [];
  }

  Future getTelegramBotMessage({int messageId = -1}) async {
    try {
      String url = api_url + 'telegram-bot-message?botId=$botId';
      if (messageId > 0) {
        url += '&messageId=$messageId';
      }

      var response = await client.get(
        url,
        headers: {'Authorization': 'Token ' + access_token},
      );

      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
        if (jsonBody['status'] == 'done') {
          return jsonBody['messages'];
        }
      }
    } catch (e) {}
    return [];
  }

  Future getAllTgbot() async {
    try {
      var response = await client.get(
        api_url + 'tg-bot/',
        headers: {'Authorization': 'Token ' + access_token},
      );

      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
        if (jsonBody['status'] == 'done') {
          return jsonBody['list'];
        }
      }
    } catch (e) {}
    return [];
  }

  Future addTelegramBot(String bot_token) async {
    try {
      var response = await client.post(api_url + 'tg-bot',
          headers: {'Authorization': 'Token ' + access_token},
          body: {'bot_token': bot_token});

      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      }
    } catch (e) {}
  }

  void getTgAccounts() async {
    print('call get account');
    try {
      final response = await client.get(api_url + 'tg-accounts',
          headers: {'Authorization': 'Token ' + access_token});

      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body);

        if (body['status'] == 'succsess') {
          List<tgModel.TelegramAccountModel> tgModel_objects =
              await compute(tgModel.parse, jsonEncode(body['acounts']));
          print(body['acounts']);
          print(tgModel_objects[0].phone);
          // print(tgModel_objects.length);
          // for (var i = 0; i < tgModel_objects.length; i++) {
          //   print(tgModel_objects[i].tg_user_id);
          // }
        }
      }
    } catch (e) {
      print('getTgAccountsEx' + e.toString());
    }
  }
}
