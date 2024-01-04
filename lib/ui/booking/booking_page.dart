import 'package:flutter/material.dart';
import 'package:hotel_ayo/model/booking.dart';
import 'package:hotel_ayo/model/kamar.dart';
import 'package:hotel_ayo/service/booking_service.dart';
import 'package:hotel_ayo/service/room_service.dart';
import 'package:hotel_ayo/ui/booking/booking_item.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  Stream<List<Booking>> getBookingList() async* {
    List<Booking> data = await BookingService().listData();
    yield data;
  }

  Stream<Kamar> getRoom(String id) async* {
    Kamar data = await RoomService().getById(id);
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Bookings")),
      body: StreamBuilder(
        stream: getBookingList(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return const Text("No data found!");
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return BookingItem(booking: snapshot.data[index]);
            },
          );
        },
      ),
    );
  }
}
