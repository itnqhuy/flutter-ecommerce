import 'package:intl/intl.dart';

class MyVNOrderUtils {
  static String formatCurrency(double amount) {
    final format = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return format.format(amount);
  }

  static String calculateTax(double productPrice) {
    const double taxRate = 0.1;
    final double taxAmount = productPrice * taxRate;
    return formatCurrency(taxAmount);
  }

  static String getShippingCost() {
    const double shippingCost = 30000;
    return formatCurrency(shippingCost);
  }

  /// Tổng cộng: giá sản phẩm + thuế + phí vận chuyển
  static String calculateTotal(double productPrice) {
    const double taxRate = 0.1;
    const double shippingCost = 30000;
    final double total = productPrice + (productPrice * taxRate) + shippingCost;
    return formatCurrency(total);
  }

  /* 
  static String calculateCartTotal(CartModel cart) {
    const double taxRate = 0.1;
    const double shippingCost = 20000;

    // Tính tổng giá sản phẩm (price * quantity)
    double subtotal = cart.items.fold(0.0, (total, item) =>
        total + (item.price * item.quantity));

    // Tổng tiền = subtotal + VAT + shipping
    double tax = subtotal * taxRate;
    double total = subtotal + tax + shippingCost;

    return formatCurrency(total);
  }
  */
}
