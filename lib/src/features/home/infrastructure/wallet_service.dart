import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:signal/src/features/common/domain/assets.dart';
import 'package:signal/src/features/home/domain/models/models.dart';

class WalletService {
  Future<List<Product>> getProducts() async {
    final jsonStr = await rootBundle.loadString(Assets.productsPath);
    final json = jsonDecode(jsonStr) as Map<String, dynamic>;
    return Products.fromJson(json).products;
  }
}
