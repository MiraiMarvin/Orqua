import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/product_model.dart';

abstract class CatalogLocalDataSource {
  Future<List<ProductModel>> getCachedProducts();
  Future<void> cacheProducts(List<ProductModel> products);
  Future<ProductModel> getCachedProduct(int id);
  Future<void> cacheProduct(ProductModel product);
}

class CatalogLocalDataSourceImpl implements CatalogLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const cachedProductsKey = 'CACHED_PRODUCTS';

  CatalogLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    final jsonString = sharedPreferences.getString(cachedProductsKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw CacheException('No cached products found');
    }
  }

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final jsonString = json.encode(products.map((p) => p.toJson()).toList());
    await sharedPreferences.setString(cachedProductsKey, jsonString);
  }

  @override
  Future<ProductModel> getCachedProduct(int id) async {
    final products = await getCachedProducts();
    try {
      return products.firstWhere((p) => p.id == id);
    } catch (e) {
      throw CacheException('Product not found in cache');
    }
  }

  @override
  Future<void> cacheProduct(ProductModel product) async {
    try {
      final products = await getCachedProducts();
      final index = products.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        products[index] = product;
      } else {
        products.add(product);
      }
      await cacheProducts(products);
    } catch (e) {
      await cacheProducts([product]);
    }
  }
}

