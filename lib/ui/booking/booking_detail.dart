import 'package:flutter/material.dart';
import 'package:hotel_ayo/helpers/format.dart';
import 'package:hotel_ayo/model/booking.dart';
import 'package:hotel_ayo/model/kamar.dart';
import 'package:hotel_ayo/service/booking_service.dart';
import 'package:hotel_ayo/service/room_service.dart';
import 'package:hotel_ayo/ui/booking/booking_page.dart';
import 'package:hotel_ayo/widget/status_booking.dart';

class BookingDetail extends StatefulWidget {
  final Booking booking;
  const BookingDetail({super.key, required this.booking});

  @override
  State<BookingDetail> createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
  Kamar? dataKamar;
  Stream<Booking> getBookingDetail() async* {
    Booking data = await BookingService().getById(widget.booking.id.toString());
    yield data;
  }

  Future<Kamar> getKamar() async {
    Kamar data = await RoomService().getById(widget.booking.roomId.toString());
    setState(() {
      dataKamar = data;
    });
    return data;
  }

  @override
  void initState() {
    super.initState();
    getKamar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Booking Detail")),
      body: StreamBuilder(
        stream: getBookingDetail(),
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

          var totalGuest = snapshot.data.guests;

          return Column(
            children: [
              Image(
                width: double.infinity,
                height: 300,
                image: NetworkImage(dataKamar!.image),
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 48),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(snapshot.data.bookId),
                          StatusBooking(status: snapshot.data.status),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dataKamar!.namaKamar,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      _detailComponent("Total Guest", '$totalGuest Orang'),
                      _detailComponent(
                        "Check in/out",
                        MyFormatter().getInOut(
                          snapshot.data.checkIn,
                          snapshot.data.checkOut,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
        ),
        padding: const EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width,
        child: _btnUpdate(),
      ),
    );
  }

  _detailComponent(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(value)
      ],
    );
  }

  _btnUpdate() {
    return StreamBuilder(
      stream: getBookingDetail(),
      builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
        ),
        onPressed: () async {
          Booking bookingUpdated = snapshot.data;

          if (snapshot.data.status == 'wait') {
            bookingUpdated.status = 'paid';
          } else if (snapshot.data.status == 'paid') {
            bookingUpdated.status = 'in';
          } else if (snapshot.data.status == 'in') {
            bookingUpdated.status = 'out';
          } else if (snapshot.data.status == 'out') {
            bookingUpdated.status = 'complete';
          }

          await BookingService()
              .ubah(bookingUpdated, snapshot.data.id)
              .then((value) {
            // setState(() {});
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const BookingPage(),
              ),
            );
          });
        },
        child: const Text("Update Status"),
      ),
    );
  }
}

// Text(widget.booking.checkIn.toString()),
