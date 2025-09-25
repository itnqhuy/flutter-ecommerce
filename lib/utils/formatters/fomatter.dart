import 'package:intl/intl.dart';

class MyFormatter {
  /// Format a given [DateTime] to 'dd-MM-yyyy'
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MM-yyyy').format(date);
  }

  /// Format a given [amount] to Vietnamese currency format, e.g. 75,000₫
  static String formatCurrency(int amount) {
    return NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(amount);
  }

  /// Format amount to 1.000.000 (no currency symbol)
  static String formatDecimalOnly(int amount) {
    return NumberFormat.decimalPattern('vi_VN').format(amount);
  }

  static String formatVietnamPhoneNumber(String phoneNumber) {
    // Bỏ ký tự không phải số
    final digits = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Bắt đầu với 84 hoặc 0
    if (digits.startsWith('84')) {
      final rest = digits.substring(2); // bỏ '84'
      return '+84 ${rest.substring(0, 3)} ${rest.substring(3, 6)} ${rest.substring(6)}';
    } else if (digits.startsWith('0')) {
      return '${digits.substring(0, 4)} ${digits.substring(4, 7)} ${digits.substring(7)}';
    } else {
      // fallback nếu không khớp định dạng
      return phoneNumber;
    }
  }

  /// Format quantity like x1, x3, x99+
  static String formatQuantity(int quantity) {
    if (quantity <= 0) return 'Out of stock';
    if (quantity > 99) return 'x99+';
    return 'x$quantity';
  }

  /// Format price per unit like 20.000₫/item
  static String formatPriceWithUnit(int price, String unit) {
    final currency = formatCurrency(price);
    return '$currency/$unit';
  }
}
