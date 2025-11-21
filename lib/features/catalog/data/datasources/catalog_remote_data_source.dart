import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../../../../core/data/seafood_products.dart';
import '../models/product_model.dart';

abstract class CatalogRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProduct(int id);
  Future<List<ProductModel>> searchProducts(String query);
}

class CatalogRemoteDataSourceImpl implements CatalogRemoteDataSource {
  final http.Client client;

  CatalogRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      return SeafoodProducts.products
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (e) {
      throw ServerException('Erreur de chargement des produits: $e');
    }
  }

  @override
  Future<ProductModel> getProduct(int id) async {
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      final productJson = SeafoodProducts.products.firstWhere(
        (p) => p['id'] == id,
        orElse: () => throw ServerException('Produit non trouvé'),
      );
      return ProductModel.fromJson(productJson);
    } catch (e) {
      throw ServerException('Erreur de chargement du produit: $e');
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      final lowerQuery = query.toLowerCase();
      final filteredProducts = SeafoodProducts.products.where((p) {
        final title = (p['title'] as String).toLowerCase();
        final category = (p['category'] as String).toLowerCase();
        final description = (p['description'] as String).toLowerCase();

        return title.contains(lowerQuery) ||
               category.contains(lowerQuery) ||
               description.contains(lowerQuery);
      }).toList();

      return filteredProducts
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (e) {
      throw ServerException('Erreur de recherche: $e');
    }
  }
}
