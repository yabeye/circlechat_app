import 'package:intl/intl.dart';

abstract class AppFormatters {
  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return '';
    }

    // Remove any non-digit characters from the phone number
    String digitsOnly = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

    if (digitsOnly.length == 10) {
      // Assuming a 10-digit number (e.g., US format: (XXX) XXX-XXXX)
      return '(${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3, 6)}-${digitsOnly.substring(6)}';
    } else if (digitsOnly.length == 11 && digitsOnly.startsWith('1')) {
      // Assuming 11-digit number with a leading 1 (e.g., US with country code)
      return '+1 (${digitsOnly.substring(1, 4)}) ${digitsOnly.substring(4, 7)}-${digitsOnly.substring(7)}';
    } else if (digitsOnly.length > 10) {
      // Example for international numbers, you can add more specific logic
      return '+${digitsOnly.substring(0, digitsOnly.length - 10)} ${digitsOnly.substring(digitsOnly.length - 10, digitsOnly.length - 7)} ${digitsOnly.substring(digitsOnly.length - 7, digitsOnly.length - 4)} ${digitsOnly.substring(digitsOnly.length - 4)}';
    } else {
      // Return the number as is if it doesn't match any known format
      return digitsOnly;
    }
  }

  static String formatTimeAmPm(DateTime dateTime) {
    final formatter = DateFormat('hh:mm a').format(dateTime).toLowerCase();
    return formatter;
  }

  static String formatChatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateToFormat = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (dateToFormat == today) {
      final hours = dateTime.hour;
      final minutes = dateTime.minute.toString().padLeft(2, '0');
      final period = hours >= 12 ? 'pm' : 'am';
      final formattedHours = hours % 12 == 0 ? 12 : hours % 12;
      return '$formattedHours:$minutes $period';
    } else if (dateToFormat == yesterday) {
      return 'Yesterday';
    } else {
      return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
    }
  }
}
