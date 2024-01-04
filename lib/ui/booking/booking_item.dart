import 'package:flutter/material.dart';
import 'package:hotel_ayo/helpers/format.dart';
import 'package:hotel_ayo/model/booking.dart';
import 'package:hotel_ayo/model/kamar.dart';
import 'package:hotel_ayo/service/room_service.dart';
import 'package:hotel_ayo/ui/booking/booking_detail.dart';
import 'package:hotel_ayo/widget/status_booking.dart';

class BookingItem extends StatefulWidget {
  final Booking booking;
  const BookingItem({super.key, required this.booking});

  @override
  State<BookingItem> createState() => _BookingItemState();
}

class _BookingItemState extends State<BookingItem> {
  Stream<Kamar> getRoom(String id) async* {
    Kamar data = await RoomService().getById(id);
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getRoom(widget.booking.roomId),
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

        var checkIn = widget.booking.checkIn;
        var checkOut = widget.booking.checkOut;
        String inOut = MyFormatter().getInOut(checkIn, checkOut);
        return _bookingCardItem(context, snapshot, inOut);
      },
    );
  }

  Card _bookingCardItem(
      BuildContext context, AsyncSnapshot<dynamic> snapshot, String inOut) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingDetail(booking: widget.booking),
            ),
          );
        },
        child: SizedBox(
          width: double.infinity,
          height: 88,
          child: Row(
            children: [
              Image(
                width: 88,
                height: 88,
                image: NetworkImage(snapshot.data.image),
                fit: BoxFit.cover,
              ),
              Expanded(
                // Wrap the Row with Expanded
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.booking.bookId),
                          StatusBooking(status: widget.booking.status),
                        ],
                      ),
                      Text(
                        snapshot.data.namaKamar,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(inOut),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
