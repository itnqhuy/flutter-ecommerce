import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyHelperFunctions {
  /// Color từ tên
  static Color? getColor(String value) {
    switch (value.toLowerCase()) {
      case 'green':
        return Colors.green;
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'pink':
        return Colors.pink;
      case 'grey':
      case 'gray':
        return Colors.grey;
      case 'purple':
        return Colors.purple;
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'indigo':
        return Colors.indigo;
      case 'yellow':
        return Colors.yellow;
      case 'orange':
        return Colors.orange;
      case 'brown':
        return Colors.brown;
      case 'cyan':
        return Colors.cyan;
      case 'lime':
        return Colors.lime;
      case 'teal':
        return Colors.teal;
      case 'amber':
        return Colors.amber;
      case 'deeporange':
      case 'deep orange':
        return Colors.deepOrange;
      case 'deeppurple':
      case 'deep purple':
        return Colors.deepPurple;
      case 'lightblue':
      case 'light blue':
        return Colors.lightBlue;
      case 'lightgreen':
      case 'light green':
        return Colors.lightGreen;
      case 'bluegrey':
      case 'blue grey':
        return Colors.blueGrey;
      case 'transparent':
        return Colors.transparent;
      default:
        return null;
    }
  }

  /// Hiển thị SnackBar
  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// Hiển thị AlertDialog
  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Điều hướng tới trang khác
  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  /// Rút gọn text nếu quá dài
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  /// Check chế độ dark
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  /// Kích thước màn hình
  static Size screenSize() => MediaQuery.of(Get.context!).size;
  static double screenHeight() => screenSize().height;
  static double screenWidth() => screenSize().width;

  /// Format ngày
  static String getFormattedDate(DateTime date,
      {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }

  /// Xóa trùng trong list
  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  /// Chia widget thành hàng theo số lượng
  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
        i,
        i + rowSize > widgets.length ? widgets.length : i + rowSize,
      );
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }
}
