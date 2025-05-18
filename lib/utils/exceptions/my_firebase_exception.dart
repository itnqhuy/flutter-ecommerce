class MyFirebaseAuthException implements Exception {
  final String code;
  final String? message;

  MyFirebaseAuthException(this.code, [this.message]);

  @override
  String toString() {
    switch (code) {
      case 'permission-denied':
        return message ?? 'Bạn không có quyền thực hiện hành động này.';
      case 'unavailable':
        return message ?? 'Máy chủ hiện không khả dụng. Vui lòng thử lại sau.';
      case 'weak-password':
        return message ?? 'Mật khẩu cung cấp quá yếu.';
      case 'email-already-in-use':
        return message ?? 'Tài khoản đã tồn tại với email này.';
      case 'invalid-email':
        return message ?? 'Địa chỉ email không hợp lệ.';
      case 'uid-already-exists':
        return message ?? 'ID người dùng đã tồn tại, vui lòng thử lại.';
      case 'web-storage-unsupported':
        return message ?? 'Web storage không được hỗ trợ.';
      case 'app-deleted':
        return message ?? 'Ứng dụng này đã bị xóa.';
      case 'user-token-mismatch':
        return message ?? 'ID người dùng không khớp với mã xác thực.';
      case 'invalid-message-payload':
        return message ?? 'Tải trọng của email xác minh không hợp lệ.';
      case 'invalid-sender':
        return message ?? 'Địa chỉ email người gửi không hợp lệ.';
      case 'invalid-recipient-email':
        return message ?? 'Địa chỉ email người nhận không hợp lệ.';
      case 'missing-action-code':
        return message ?? 'Mã hành động thiếu.';
      case 'user-token-expired':
        return message ?? 'Mã xác thực của người dùng đã hết hạn.';
      case 'INVALID_LOGIN_CREDENTIALS':
        return message ?? 'Thông tin đăng nhập không hợp lệ.';
      case 'expired-action-code':
        return message ?? 'Mã hành động đã hết hạn.';
      case 'credential-already-in-use':
        return message ?? 'Tài khoản này đã được liên kết với email khác.';
      case 'user-not-found':
        return message ?? 'Không tìm thấy tài khoản với email này.';
      case 'wrong-password':
        return message ?? 'Mật khẩu không đúng. Vui lòng thử lại.';
      case 'too-many-requests':
        return message ?? 'Đăng nhập quá nhiều lần. Vui lòng thử lại sau.';
      default:
        return message ?? 'Đã xảy ra lỗi Firebase. Vui lòng thử lại.';
    }
  }
}
