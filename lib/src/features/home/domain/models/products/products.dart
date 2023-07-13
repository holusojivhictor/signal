import 'package:equatable/equatable.dart';

class Products extends Equatable {
  const Products({required this.products});

  Products.fromJson(Map<String, dynamic> json)
      : products = (json['products'] as List<dynamic>)
            .map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList();

  final List<Product> products;

  @override
  List<Object?> get props => <Object?>[products];
}

class Product extends Equatable {
  const Product({
    required this.id,
    required this.productId,
    required this.asset,
    required this.change,
  });

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int? ?? 0,
        productId = json['productId'] as String? ?? '',
        asset = json['asset'] as String? ?? '',
        change = json['change'] as double? ?? 0;

  final int id;
  final String productId;
  final String asset;
  final double change;

  @override
  List<Object?> get props => <Object?>[
    id,
    productId,
    asset,
    change,
  ];
}
