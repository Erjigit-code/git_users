// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "users_list": "Users List",
  "user_name": "Username:",
  "no_internet_connection": "No internet connection 🛜",
  "Error_while_receiving_data": "Error while receiving data ❗️",
  "select_language": "Select language",
  "followers": "Followers",
  "following": "Following"
};
static const Map<String,dynamic> ru = {
  "users_list": "Список пользователей",
  "user_name": "Пользователь:",
  "no_internet_connection": "Нет интернет соединения 🛜",
  "Error_while_receiving_data": "Ошибка при получении данных ❗️",
  "select_language": "Выберите язык",
  "followers": "Подписчики",
  "following": "Подписки"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ru": ru};
}
