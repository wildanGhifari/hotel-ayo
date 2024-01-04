import 'package:intl/intl.dart';

class MyFormatter {
  String getInOut(String inDate, String outDate) {
    var checkIn = DateFormat.yMMMd().format(
      DateTime.parse(inDate),
    );

    var checkOut = DateFormat.yMMMd().format(
      DateTime.parse(outDate),
    );

    return "$checkIn - $checkOut";
  }

  String toRupiah(String price) {
    var currency = NumberFormat.currency(locale: "id_ID", symbol: "Rp. ");
    return currency.format(int.parse(price));
  }
}
