import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String unslug() {
    return replaceAll("_", " ");
  }

  String uppercaseFirst() {
    List arrStr = split(" ");
    String formatted = "";
    for (var part in arrStr) {
      formatted += part.toString().capitalize() + " ";
    }
    return formatted.trim();
  }

  bool isNullOrEmpty() {
    if (this == null || toString() == "" || this == "null" || isEmpty) {
      return true;
    }
    return false;
  }

  bool isNumeric() {
    if (this == null) {
      return false;
    }
    return double.tryParse(this) != null;
  }

  String slugify() {
    String str = toLowerCase().replaceAll("(", "").replaceAll(")", "");
    return str.replaceAll(" ", "_");
  }

  String initials() {
    String initials = "";
    List parts = split(" ");

    if (length == 1) {
      initials = parts[0].toString().substring(0, 1);
    } else {
      if (parts.length > 1) {
        // This check caters for a single letter with a space after it
        String secondLetter = parts[1].toString().isEmpty
            ? ''
            : parts[1].toString().substring(0, 1);
        initials = parts[0].toString().substring(0, 1) + secondLetter;
      } else {
        initials = parts[0].toString().substring(0, 2);
      }
    }
    initials = initials.toUpperCase();
    return initials;
  }

  String formatMoney() {
    return NumberFormat.currency(symbol: '₦').format(this);
  }

  String firstName() {
    return substring(
      0,
      !contains(' ') ? length : indexOf(' '),
    );
  }
}
