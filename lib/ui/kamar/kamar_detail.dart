import 'package:flutter/material.dart';
import 'package:hotel_ayo/helpers/format.dart';
import 'package:hotel_ayo/model/kamar.dart';
import 'package:hotel_ayo/service/room_service.dart';
import 'package:hotel_ayo/ui/booking/booking_form.dart';
import 'package:hotel_ayo/ui/kamar/kamar_page.dart';
import 'package:hotel_ayo/ui/kamar/kamar_update_form.dart';

class KamarDetail extends StatefulWidget {
  final Kamar kamar;
  const KamarDetail({super.key, required this.kamar});

  @override
  State<KamarDetail> createState() => _KamarDetailState();
}

class _KamarDetailState extends State<KamarDetail> {
  Stream<Kamar> getKamarDetail() async* {
    Kamar data = await RoomService().getById(widget.kamar.id.toString());
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Room Detail"),
        actions: [_btnEdit(widget.kamar), _btnDelete()],
      ),
      body: StreamBuilder(
        stream: getKamarDetail(),
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
          return Column(
            children: [
              Image(
                width: double.infinity,
                height: 300,
                image: NetworkImage(snapshot.data.image),
                fit: BoxFit.cover,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 48),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data.namaKamar,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    _roomStatus(snapshot.data.status),
                    const SizedBox(height: 12),
                    Text(
                      MyFormatter().toRupiah(snapshot.data.harga),
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(snapshot.data.deskripsi),
                  ],
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
        child: _btnBooking(widget.kamar),
      ),
    );
  }

  _roomStatus(String status) {
    if (status == "false") {
      return const Text("Not Available");
    }
    return const Text("Available");
  }

  _btnEdit(Kamar selectedRoom) {
    return IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KamarUpdateForm(kamar: selectedRoom),
          ),
        );
      },
    );
  }

  _btnBooking(Kamar selectedRoom) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingForm(kamar: selectedRoom),
          ),
        );
      },
      child: const Text("Booking Room"),
    );
  }

  _btnDelete() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: IconButton(
        color: Colors.red[400],
        icon: const Icon(Icons.delete_outlined),
        onPressed: () {
          AlertDialog showAlertDialog = AlertDialog(
            title: const Text("Delete room"),
            icon: const Icon(Icons.warning_rounded),
            iconColor: Colors.red,
            content: const Text("Are you sure want to delete this room?"),
            actions: [
              StreamBuilder(
                stream: getKamarDetail(),
                builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () async {
                    await RoomService().hapus(snapshot.data).then((value) {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const KamarPage(),
                        ),
                      );
                    });
                  },
                  child: const Text("Delete"),
                ),
              ),
              ElevatedButton(
                child: const Text("No"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );

          showDialog(context: context, builder: (context) => showAlertDialog);
        },
      ),
    );
  }
}
