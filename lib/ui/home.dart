import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.grey.shade800,
          statusBarBrightness: Brightness.dark,
        ),
        title: const Text("Hotel Ayo"),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        crossAxisCount: 2,
        children: [
          _tile(
            "Available Rooms",
            "Jumlah total kamar yang tersedia",
            "123",
          ),
          _tile(
            "Total Bookings",
            "Jumlah total booking selama tahun 2023",
            "123",
          ),
        ],
      ),
    );
  }

  _tile(String title, String desc, String total) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[500],
                  ),
                ),
                Text(desc),
              ],
            ),
            Text(
              total,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _featuredRoom() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Promo kamar bulan ini"),
        Container(
          height: 280,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _roomCard(),
              _roomCard(),
              _roomCard(),
              _roomCard(),
            ],
          ),
        ),
      ],
    );
  }

  _roomCard() {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 160,
              width: double.infinity,
              child: Image(
                width: double.maxFinite,
                image: NetworkImage('https://picsum.photos/300/300'),
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              child: const Text("Deluxe King Bed Room"),
            )
          ],
        ),
      ),
    );
  }
}
