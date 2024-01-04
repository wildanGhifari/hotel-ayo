import 'package:dio/dio.dart';
import 'package:hotel_ayo/helpers/api_client2.dart';
import 'package:hotel_ayo/model/user.dart';

class UserService {
  Future<List> getUserRaw() async {
    final response = await ApiClient().get('users');
    final List data = response.data as List;
    return data;
  }

  Future<List<User>> listData() async {
    final response = await ApiClient().get('users');
    final List data = response.data as List;
    List<User> results = data.map((e) => User.fromJson(e)).toList();
    return results;
  }

  Future<User> simpan(User user) async {
    var data = user.toJson();
    final Response response = await ApiClient().post('users', data);
    User result = User.fromJson(response.data);
    return result;
  }

  Future<User> ubah(User user, String id) async {
    var data = user.toJson();
    final Response response = await ApiClient().put('users/$id', data);
    User result = User.fromJson(response.data);
    return result;
  }

  Future<User> getById(String id) async {
    final Response response = await ApiClient().get('users/$id');
    User result = User.fromJson(response.data);
    return result;
  }

  Future<User> hapus(User user) async {
    final Response response = await ApiClient().delete('users/${user.id}');
    User result = User.fromJson(response.data);
    return result;
  }
}
