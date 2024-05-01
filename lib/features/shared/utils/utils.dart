import 'package:intl/intl.dart';

class Utils {
  static String formatCurrency(double? amount) {
    NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'en',
      symbol: '',
    );

    return currencyFormat.format(amount ?? 0);
  }
}
