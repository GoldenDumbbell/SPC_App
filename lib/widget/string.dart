import 'package:intl/intl.dart';

String formatMoney(double x) {
  String formattedAmount = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: '',
  ).format(x);
  return formattedAmount;
}
