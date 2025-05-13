class MyValidator {
  MyValidator._();
  // Validate email address
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập email.';
    }

    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Email không hợp lệ.';
    }

    return null;
  }

  // Validate password strength
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu.';
    }

    if (value.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự.';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Mật khẩu phải chứa ít nhất một chữ cái in hoa.';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Mật khẩu phải chứa ít nhất một số.';
    }

    if (!value.contains(RegExp('[!@#\$%^&*()_+={}\[\]:;"\'<>,.?/|\\`~]'))) {
      return 'Mật khẩu phải chứa ít nhất một ký tự đặc biệt.';
    }

    return null;
  }

  // Validate Vietnamese phone number
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập số điện thoại.';
    }

    // Việt Nam: bắt đầu bằng 0, theo sau là 9 hoặc 10 chữ số
    final phoneRegex = RegExp(r'^(0[3|5|7|8|9])+([0-9]{8})$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Số điện thoại không hợp lệ (VD: 0901234567).';
    }

    return null;
  }

  // Validate quantity (must be positive integer)
  static String? validateQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập số lượng.';
    }

    final quantity = int.tryParse(value);
    if (quantity == null || quantity <= 0) {
      return 'Số lượng phải là số nguyên dương.';
    }

    return null;
  }

  // Validate price (must be a positive number)
  static String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập đơn giá.';
    }

    final parsed = double.tryParse(value.replaceAll(',', ''));
    if (parsed == null || parsed <= 0) {
      return 'Đơn giá phải là số lớn hơn 0.';
    }

    return null;
  }

  // Validate CMND/CCCD (Vietnamese ID: 9 or 12 digits)
  static String? validateVietnameseID(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập số CMND/CCCD.';
    }

    final idRegex = RegExp(r'^\d{9}$|^\d{12}$');
    if (!idRegex.hasMatch(value)) {
      return 'Số CMND/CCCD phải có 9 hoặc 12 chữ số.';
    }

    return null;
  }

  // Validate general required text field (e.g. name)
  static String? validateRequiredField(String? value,
      {String fieldName = 'Trường này'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName không được để trống.';
    }

    return null;
  }
}
