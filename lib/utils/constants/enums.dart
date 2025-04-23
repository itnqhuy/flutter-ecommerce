// ENUMS FOR THE WHOLE APP

// NOTE: Enums cannot be created inside a class.

/// Text size options for flexible UI scaling
enum TextSizes {
  small,
  medium,
  large,
}

/// Order statuses used in order tracking
enum OrderStatus {
  processing,
  shipped,
  delivered,
  cancelled, // optional: add if needed
  returned, // optional: add if needed
}

/// Supported payment methods in the checkout flow
enum PaymentMethods {
  paypal,
  googlePay,
  applePay,
  visa,
  masterCard,
  creditCard,
  paystack,
  razorPay,
  paytm,
  cod, // Cash on Delivery
  bankTransfer // Optional: add if needed
}

extension PaymentMethodsExt on PaymentMethods {
  String get displayName {
    switch (this) {
      case PaymentMethods.googlePay:
        return 'Google Pay';
      case PaymentMethods.applePay:
        return 'Apple Pay';
      case PaymentMethods.visa:
        return 'Visa';
      case PaymentMethods.cod:
        return 'Cash on Delivery';
      default:
        return name;
    }
  }
}
