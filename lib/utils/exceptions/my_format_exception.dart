class MyFormatException implements Exception {
  const MyFormatException();

  @override
  String toString() => 'Dữ liệu không hợp lệ.';
}
