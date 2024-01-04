import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_ayo/model/kamar.dart';
import 'package:hotel_ayo/service/room_service.dart';
import 'package:hotel_ayo/ui/kamar/kamar_detail.dart';

class KamarForm extends StatefulWidget {
  const KamarForm({super.key});

  @override
  State<KamarForm> createState() => _KamarFormState();
}

class _KamarFormState extends State<KamarForm> {
  final _formKey = GlobalKey<FormState>();
  final _controllerUrlImage = TextEditingController();
  final _controllerNamaKamar = TextEditingController();
  final _controllerStatus = TextEditingController();
  final _controllerDeskripsiKamar = TextEditingController();
  final _controllerHargaKamar = TextEditingController();

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
      child: const Text("Create new room"),
      onPressed: () async {
        Kamar newKamar = Kamar(
          image: _controllerUrlImage.text,
          namaKamar: _controllerNamaKamar.text,
          status: _controllerStatus.text,
          deskripsi: _controllerDeskripsiKamar.text,
          harga: _controllerHargaKamar.text,
        );

        await RoomService().simpan(newKamar).then(
              (value) => {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KamarDetail(kamar: newKamar),
                  ),
                )
              },
            );
      },
    );
  }
}
