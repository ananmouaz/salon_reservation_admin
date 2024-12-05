import 'package:easy_localization/easy_localization.dart';

class Formatters {
  static String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  static String formatDatetime(String date) {
    // Parse the input string into a DateTime object
    DateTime dateTime = DateTime.parse(date);

    // Format the DateTime object into the desired output format
    return DateFormat("dd/MM/yyyy, HH:mm").format(dateTime);
  }

  static String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input; // Return the original string if it's empty
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  static String formatPrice(double price) {
    // Create a NumberFormat instance for Syrian Pound (SYP)
    final NumberFormat formatter = NumberFormat.currency(locale: 'ar_SY', symbol: 'lira'.tr(), decimalDigits: 0);

    // Format the price using the NumberFormat instance
    String formattedPrice = formatter.format(price);

    return formattedPrice;
  }
}