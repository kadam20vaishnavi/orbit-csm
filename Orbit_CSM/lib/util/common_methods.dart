import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommonMethods{
  // Method to show SnackBar
  static void showSnackBar(BuildContext context, String message, {Color backgroundColor = Colors.green}) {
    final snackBar = SnackBar(
      content: Text(message,  style: const TextStyle(fontSize: 12.0, color: Colors.white), ),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating, // Allows the SnackBar to float and be positioned with margin
      margin: const EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0), // Adjust bottom margin as needed
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static String convertDate(String? date1, String? inputFormatPattern, String? outputFormatPattern) {
    if (date1 == null || inputFormatPattern == null || outputFormatPattern == null) {
      return ""; // Return empty string if any value is null
    }

    try {
      DateTime parsedDate = DateFormat(inputFormatPattern).parse(date1);
      String formattedDate = DateFormat(outputFormatPattern).format(parsedDate);
      print(formattedDate); // Print the converted date (like Kotlin's println)
      return formattedDate;
    } catch (e) {
      print("Date conversion error: $e");
      return ""; // Return empty string if parsing fails
    }
  }
}