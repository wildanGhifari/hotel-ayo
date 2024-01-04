import 'package:flutter/material.dart';

class StatusBooking extends StatelessWidget {
  final String status;
  const StatusBooking({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    if (status == 'wait') {
      return Badge(
        label: Text(status),
        padding: const EdgeInsets.symmetric(horizontal: 6),
        backgroundColor: Colors.blue,
        textColor: Colors.white,
      );
    } else if (status == 'paid') {
      return Badge(
        label: Text(status),
        padding: const EdgeInsets.symmetric(horizontal: 6),
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } else if (status == 'in' || status == 'out') {
      return Badge(
        label: Text(status),
        padding: const EdgeInsets.symmetric(horizontal: 6),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        textColor: Colors.white,
      );
    } else {
      return Badge(
        label: Text(status),
        padding: const EdgeInsets.symmetric(horizontal: 6),
        backgroundColor: Theme.of(context).colorScheme.background,
        textColor: Colors.white,
      );
    }
  }
}
