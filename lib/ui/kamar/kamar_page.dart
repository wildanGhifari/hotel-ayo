import 'package:flutter/material.dart';
import 'package:hotel_ayo/helpers/user_info.dart';
import 'package:hotel_ayo/model/kamar.dart';
import 'package:hotel_ayo/service/room_service.dart';
import 'package:hotel_ayo/ui/kamar/kamar_form.dart';
import 'package:hotel_ayo/ui/kamar/kamar_item.dart';

class KamarPage extends StatefulWidget {
  const KamarPage({super.key});

  @override
  State<KamarPage> createState() => _KamarPageState();
}

class _KamarPageState extends State<KamarPage> {
  Stream<List<Kamar>> getList() async* {
    List<Kamar> data = await RoomService().listData();
    yield data;
  }

  String? isAdmin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserInfo().getToken().then((value) => setState(() => isAdmin = value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("Rooms"), actions: [_addNewRoom(isAdmin)]),
      body: _roomCards(),
    );
  }

  _roomCards() {
    return StreamBuilder(
      stream: getList(),
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

        return GridView.count(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          crossAxisCount: 2,
          children: List.generate(snapshot.data.length, (index) {
            return KamarItem(kamar: snapshot.data[index]);
          }),
        );
      },
    );
  }

  _addNewRoom(token) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const KamarForm()),
        );
      },
      icon: const Icon(Icons.add),
      label: const Text("New Room"),
    );

    // if (token == "admin") {
    //   return ElevatedButton.icon(
    //     onPressed: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(builder: (context) => const KamarForm()),
    //       );
    //     },
    //     icon: const Icon(Icons.add),
    //     label: const Text("New Room"),
    //   );
    // }

    // return const Text('');
  }
}
