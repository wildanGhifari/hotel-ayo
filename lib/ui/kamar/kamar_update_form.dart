import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_ayo/model/kamar.dart';
import 'package:hotel_ayo/service/room_service.dart';
import 'package:hotel_ayo/ui/kamar/kamar_page.dart';

class KamarUpdateForm extends StatefulWidget {
  final Kamar kamar;
  const KamarUpdateForm({super.key, required this.kamar});

  @override
  State<KamarUpdateForm> createState() => _KamarUpdateFormState();
}

class _KamarUpdateFormState extends State<KamarUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _controllerUrlImage = TextEditingController();
  final _controllerNamaKamar = TextEditingController();
  final _controllerStatus = TextEditingController();
  final _controllerDeskripsiKamar = TextEditingController();
  final _controllerHargaKamar = TextEditingController();

  Future<Kamar> getSelectedKamar() async {
    Kamar data = await RoomService().getById(widget.kamar.id.toString());
    setState(() {
      _controllerUrlImage.text = data.image;
      _controllerNamaKamar.text = data.namaKamar;
      _controllerDeskripsiKamar.text = data.deskripsi;
      _controllerStatus.text = data.status;
      _controllerHargaKamar.text = data.harga;
    });
    return data;
  }

  @override
  void initState() {
    super.initState();
    getSelectedKamar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Room")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _fieldUrlImg(),
              _fieldNama(),
              _fieldStatus(),
              _fieldHarga(),
              _fieldDeskripsi(),
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

  _fieldUrlImg() {
    return TextField(
      decoration: const InputDecoration(labelText: "Image Url"),
      controller: _controllerUrlImage,
    );
  }

  _fieldNama() {
    return TextField(
      decoration: const InputDecoration(labelText: "Room name"),
      controller: _controllerNamaKamar,
    );
  }

  _fieldStatus() {
    return TextField(
      decoration: const InputDecoration(
        labelText: "Status",
        hintText: "true/false",
      ),
      controller: _controllerStatus,
    );
  }

  _fieldDeskripsi() {
    return TextField(
      decoration: const InputDecoration(
        labelText: "Description",
        hintText: "Enter description here...",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      controller: _controllerDeskripsiKamar,
      maxLines: 6,
      scrollPadding: const EdgeInsets.all(8),
      keyboardType: TextInputType.multiline,
    );
  }

  _fieldHarga() {
    return TextField(
      decoration: const InputDecoration(labelText: "Price"),
      controller: _controllerHargaKamar,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
    );
  }

  _btnSimpan() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      onPressed: () async {
        Kamar roomUpdated = Kamar(
          image: _controllerUrlImage.text,
          namaKamar: _controllerNamaKamar.text,
          status: _controllerStatus.text,
          deskripsi: _controllerDeskripsiKamar.text,
          harga: _controllerHargaKamar.text,
        );
        String id = widget.kamar.id.toString();

        await RoomService().ubah(roomUpdated, id).then(
          (value) {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const KamarPage(),
              ),
            );
          },
        );
      },
      child: const Text("Update Room"),
    );
  }
}
