class CartItemModel {
  final String title;
  final double price;
  final String? image;
  final int quantity;
  final String skuId;
  final String? brandName;
  final Map<String, String>? selectedSKU;

  /// Constructor
  CartItemModel({
    required this.skuId,
    required this.quantity,
    this.price = 0.0,
    this.title = '',
    this.image,
    this.brandName,
    this.selectedSKU,
  });

  /// Empty cart item
  static CartItemModel empty() => CartItemModel(
        skuId: '',
        quantity: 0,
      );

  /// Convert a CartItem to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
      'skuId': skuId,
      'brandName': brandName,
      'selectedSKU': selectedSKU,
    };
  }

  /// Create CartItem from JSON
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      title: json['title'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      image: json['image'],
      quantity: json['quantity'] ?? 0,
      skuId: json['skuId'] ?? '',
      brandName: json['brandName'],
      selectedSKU: Map<String, String>.from(
        json['selectedSKU'] ?? {},
      ),
    );
  }

  CartItemModel copyWith({
    String? title,
    double? price,
    String? image,
    int? quantity,
    String? skuId,
    String? brandName,
    Map<String, String>? selectedSKU,
  }) {
    return CartItemModel(
      title: title ?? this.title,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
      skuId: skuId ?? this.skuId,
      brandName: brandName ?? this.brandName,
      selectedSKU: selectedSKU ?? this.selectedSKU,
    );
  }
}
