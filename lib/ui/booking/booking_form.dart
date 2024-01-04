import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_ayo/helpers/user_info.dart';
import 'package:hotel_ayo/model/booking.dart';
import 'package:hotel_ayo/model/kamar.dart';
import 'package:hotel_ayo/service/booking_service.dart';
import 'package:hotel_ayo/ui/booking/booking_detail.dart';

class BookingForm extends StatefulWidget {
  final Kamar kamar;
  const BookingForm({super.key, required this.kamar});

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();
  final _controllerGuest = TextEditingController();
  final _controllerCheckIn = TextEditingController();
  final _controllerCheckOut = TextEditingController();

  String? idUser;
  Future<String> getIdUser() async {
    String? id = await UserInfo().getUserID();
    setState(() {
      idUser = id.toString();
    });

    return id.toString();
  }

  @override
  void initState() {
    super.initState();
    getIdUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _selectedRoom(),
              _fieldGuest(),
              _fieldCheckIn(),
              _fieldCheckOut(),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
        ),
        padding: const EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width,
        child: _btnSimpan(),
      ),
    );
  }

  _fieldGuest() {
    return TextField(
      decoration: const InputDecoration(labelText: "Total Guest(s)"),
      controller: _controllerGuest,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
    );
  }

  _fieldCheckIn() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Check-in Date",
        hintText: "DD/MM/YYYY",
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_month_rounded),
          onPressed: () {},
        ),
      ),
      controller: _controllerCheckIn,
      keyboardType: TextInputType.datetime,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp("[0-9/]"))
      ],
    );
  }

  _fieldCheckOut() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Check-out Date",
        hintText: "DD/MM/YYYY",
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_month_rounded),
          onPressed: () {},
        ),
      ),
      controller: _controllerCheckOut,
      keyboardType: TextInputType.datetime,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp("[0-9/]"))
      ],
    );
  }

  _selectedRoom() {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(
        width: double.infinity,
        height: 88,
        child: Row(
          children: [
            Image(
              width: 88,
              height: 88,
              image: NetworkImage(widget.kamar.image),
              fit: BoxFit.cover,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.kamar.namaKamar,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(widget.kamar.status),
                  Text(widget.kamar.harga),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _btnSimpan() {
    return ElevatedButton(
      onPressed: () async {
        var checkIn = _controllerCheckIn.text.split("/").reversed.toList();
        var checkOut = _controllerCheckOut.text.split("/").reversed.toList();
        var roomId = widget.kamar.id.toString();
        var checkInRaw = checkIn.join('').toString();
        Booking newBooking = Booking(
          bookId: '#AYO$roomId$checkInRaw',
          roomId: widget.kamar.id.toString(),
          userId: idUser.toString(),
          guests: _controllerGuest.text,
          checkIn: DateTime.parse(checkIn.join("-")).toString(),
          checkOut: DateTime.parse(checkOut.join("-")).toString(),
          status: "wait",
        );

        await BookingService().simpan(newBooking).then(
              (value) => {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingDetail(booking: newBooking),
                  ),
                )
              },
            );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      child: const Text("Confirm Booking"),
    );
  }
}
