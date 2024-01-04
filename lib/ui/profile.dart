import 'package:flutter/material.dart';
import 'package:hotel_ayo/auth/login.dart';
import 'package:hotel_ayo/helpers/user_info.dart';
import 'package:hotel_ayo/model/booking.dart';
import 'package:hotel_ayo/model/user.dart';
import 'package:hotel_ayo/service/booking_service.dart';
import 'package:hotel_ayo/service/user_service.dart';
import 'package:hotel_ayo/ui/booking/booking_item.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? userId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserInfo().getUserID().then((value) => setState(() => userId = value));
  }

  Stream<User> getUser() async* {
    User data = await UserService().getById(userId.toString());
    yield data;
  }

  Stream<List<Booking>> getBooking() async* {
    List<Booking> dataBookings = await BookingService().listData();
    Iterable<Booking> data = dataBookings.where(
      (el) => el.userId == userId.toString(),
    );

    yield data.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: IconButton(
              onPressed: () {
                UserInfo().logout();
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              },
              icon: const Icon(Icons.logout),
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: getUser(),
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

          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _UserDetail(snapshot, context),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  Text(
                    "My Bookings",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  _DataBookingUser(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  StreamBuilder<List<Booking>> _DataBookingUser() {
    return StreamBuilder(
      stream: getBooking(),
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
          primary: false,
          shrinkWrap: true,
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return BookingItem(booking: snapshot.data[index]);
          },
        );
      },
    );
  }

  Row _UserDetail(AsyncSnapshot<dynamic> snapshot, BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 48,
          child: Image(
            image: NetworkImage(snapshot.data.avatar),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                snapshot.data.fullname,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              Text(snapshot.data.username),
              Text(snapshot.data.email)
            ],
          ),
        ),
      ],
    );
  }
}
