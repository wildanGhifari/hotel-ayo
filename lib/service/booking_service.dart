import 'package:dio/dio.dart';
import 'package:hotel_ayo/helpers/api_client.dart';
import 'package:hotel_ayo/model/booking.dart';

class BookingService {
  Future<List<Booking>> listData() async {
    final response = await ApiClient().get('booking');
    final List data = response.data as List;
    List<Booking> results = data.map((e) => Booking.fromJson(e)).toList();
    return results;
  }

  Future<Booking> simpan(Booking booking) async {
    var data = booking.toJson();
    final Response response = await ApiClient().post('booking', data);
    Booking result = Booking.fromJson(response.data);
    return result;
  }

  Future<Booking> ubah(Booking booking, String id) async {
    var data = booking.toJson();
    final Response response = await ApiClient().put('booking/$id', data);
    Booking result = Booking.fromJson(response.data);
    return result;
  }

  Future<Booking> getById(String id) async {
    final Response response = await ApiClient().get('booking/$id');
    Booking result = Booking.fromJson(response.data);
    return result;
  }

  Future<Booking> hapus(Booking booking) async {
    final Response response = await ApiClient().delete('booking/${booking.id}');
    Booking result = Booking.fromJson(response.data);
    return result;
  }
}
