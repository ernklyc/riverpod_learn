import 'package:dio/dio.dart';
import 'package:riverpod_learn/models/user.dart';

class UserService {
  final Dio _dio = Dio();
  Future<List<User>> fetchUsers() async {
    final response = await _dio.get('https://reqres.in/api/users?page=2');
    final List<dynamic> data = response.data['data'];
    return data.map((json) => User.fromJson(json)).toList();
  }
}