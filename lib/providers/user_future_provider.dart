import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learn/models/user.dart';
import 'package:riverpod_learn/services/user_service.dart';

final userFutureProvider = FutureProvider<List<User>>((ref) async {
  final userService = UserService();
  return userService.fetchUsers();
});