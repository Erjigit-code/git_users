// user_repository.dart
import 'package:dio/dio.dart';

class UserRepository {
  final Dio _dio = Dio();
  final String _url = 'https://api.github.com/users';
  final String _token = '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';

  UserRepository() {
    _dio.options.headers['Authorization'] = 'token $_token';
  }

  Future<List<dynamic>> fetchUsers() async {
    final response = await _dio.get(_url);
    List<dynamic> users = response.data;

    for (var user in users) {
      final userDetails = await _dio.get(user['url']);
      user['followers'] = userDetails.data['followers'];
      user['following'] = userDetails.data['following'];
      user['avatar_url'] = userDetails.data['avatar_url'];
    }

    return users;
  }
}
