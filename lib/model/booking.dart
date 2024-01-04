// import 'package:intl/intl.dart';

class Booking {
  String? id;
  String bookId;
  String roomId;
  String userId;
  String guests;
  String checkIn;
  String checkOut;
  String status;

  Booking({
    this.id,
    required this.bookId,
    required this.roomId,
    required this.userId,
    required this.guests,
    required this.checkIn,
    required this.checkOut,
    required this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json['id'],
        bookId: json['bookId'],
        roomId: json['roomId'],
        userId: json['userId'],
        guests: json['guests'].toString(),
        checkIn: json['checkIn'],
        checkOut: json['checkOut'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        "bookId": bookId,
        "roomId": roomId,
        "userId": userId,
        "guests": guests,
        "checkIn": checkIn,
        "checkOut": checkOut,
        "status": status,
      };
}
