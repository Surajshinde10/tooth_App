class Order {
  final String productId;
  final String productName;
  final String productImage;
  final int quantity;

  Order({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'quantity': quantity,
    };
  }
}
