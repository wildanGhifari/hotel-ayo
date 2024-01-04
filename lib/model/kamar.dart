// import 'package:intl/intl.dart';

class Kamar {
  String? id;
  String image;
  String namaKamar;
  String status;
  String deskripsi;
  String harga;

  Kamar({
    this.id,
    required this.image,
    required this.namaKamar,
    required this.status,
    required this.deskripsi,
    required this.harga,
  });

  factory Kamar.fromJson(Map<String, dynamic> json) => Kamar(
        id: json['id'],
        image: json['image'],
        namaKamar: json['nameRoom'],
        status: json['status'].toString(),
        deskripsi: json['description'],
        harga: json['price'],
      );

  Map<String, dynamic> toJson() => {
        "image": image.toString(),
        "nameRoom": namaKamar,
        "status": bool.parse(status),
        "description": deskripsi,
        "price": harga,
      };
}
