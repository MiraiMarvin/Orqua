import 'package:flutter/foundation.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_product.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/search_products.dart';

enum CatalogState { initial, loading, loaded, error }

class CatalogProvider with ChangeNotifier {
  final GetProducts getProducts;
  final GetProduct getProduct;
  final SearchProducts searchProducts;

  CatalogProvider({
    required this.getProducts,
    required this.getProduct,
    required this.searchProducts,
  });

  CatalogState _state = CatalogState.initial;
  List<Product> _products = [];
  Product? _selectedProduct;
  String _errorMessage = '';

  CatalogState get state => _state;
  List<Product> get products => _products;
  Product? get selectedProduct => _selectedProduct;
  String get errorMessage => _errorMessage;

  Future<void> loadProducts() async {
    _state = CatalogState.loading;
    notifyListeners();

    final result = await getProducts(NoParams());
    result.fold(
      (failure) {
        _state = CatalogState.error;
        _errorMessage = failure.message;
        notifyListeners();
      },
      (products) {
        _state = CatalogState.loaded;
        _products = products;
        notifyListeners();
      },
    );
  }

  Future<void> loadProduct(int id) async {
    _state = CatalogState.loading;
    notifyListeners();

    final result = await getProduct(GetProductParams(id: id));
    result.fold(
      (failure) {
        _state = CatalogState.error;
        _errorMessage = failure.message;
        notifyListeners();
      },
      (product) {
        _state = CatalogState.loaded;
        _selectedProduct = product;
        notifyListeners();
      },
    );
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      await loadProducts();
      return;
    }

    _state = CatalogState.loading;
    notifyListeners();

    final result = await searchProducts(SearchProductsParams(query: query));
    result.fold(
      (failure) {
        _state = CatalogState.error;
        _errorMessage = failure.message;
        notifyListeners();
      },
      (products) {
        _state = CatalogState.loaded;
        _products = products;
        notifyListeners();
      },
    );
  }
}

