import 'package:dio/dio.dart';
import 'package:hotel_ayo/helpers/api_client.dart';
import 'package:hotel_ayo/model/kamar.dart';

class RoomService {
  Future<List<Kamar>> listData() async {
    final response = await ApiClient().get('rooms');
    final List data = response.data as List;

    List<Kamar> results = data.map((e) => Kamar.fromJson(e)).toList();
    return results;
  }

  Future<Kamar> simpan(Kamar kamar) async {
    var data = kamar.toJson();
    final Response response = await ApiClient().post('rooms', data);
    Kamar result = Kamar.fromJson(response.data);
    return result;
  }

  Future<Kamar> ubah(Kamar kamar, String id) async {
    var data = kamar.toJson();
    final Response response = await ApiClient().put('rooms/$id', data);
    Kamar result = Kamar.fromJson(response.data);
    return result;
  }

  Future<Kamar> getById(String id) async {
    final Response response = await ApiClient().get('rooms/$id');
    Kamar result = Kamar.fromJson(response.data);
    return result;
  }

  Future<Kamar> hapus(Kamar kamar) async {
    final Response response = await ApiClient().delete('rooms/${kamar.id}');
    Kamar result = Kamar.fromJson(response.data);
    return result;
  }
}
