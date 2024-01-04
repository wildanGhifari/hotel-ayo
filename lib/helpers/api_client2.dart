import 'package:dio/dio.dart';

const Duration connecTimeOut = Duration(milliseconds: 5000);
const Duration receiveTimeOut = Duration(milliseconds: 3000);

final Dio dio = Dio(
  BaseOptions(
    baseUrl: 'https://658d423d7c48dce94738cd1b.mockapi.io/api/v2/',
    connectTimeout: connecTimeOut,
    receiveTimeout: receiveTimeOut,
  ),
);

class ApiClient {
  Future<Response> get(String path) async {
    try {
      final response = await dio.get(Uri.encodeFull(path));
      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> post(String path, dynamic data) async {
    try {
      final response = await dio.post(Uri.encodeFull(path), data: data);
      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> put(String path, dynamic data) async {
    try {
      final response = await dio.put(Uri.encodeFull(path), data: data);
      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> delete(String path) async {
    try {
      final response = await dio.delete(Uri.encodeFull(path));
      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
