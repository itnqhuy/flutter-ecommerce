class MyPlatformException implements Exception {
  final String code;
  final String? message;

  MyPlatformException(this.code, this.message);

  @override
  String toString() {
    switch (code) {
      case 'network_error':
        return 'Lỗi mạng. Vui lòng kiểm tra kết nối internet của bạn.';
      case 'device_not_supported':
        return 'Tính năng này không được hỗ trợ trên thiết bị của bạn.';
      default:
        return 'Đã xảy ra lỗi nền tảng. Vui lòng thử lại.';
    }
  }
}
