import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Auth
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/sign_in.dart';
import '../../features/auth/domain/usecases/sign_out.dart';
import '../../features/auth/domain/usecases/sign_up.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';

// Catalog
import '../../features/catalog/data/datasources/catalog_local_data_source.dart';
import '../../features/catalog/data/datasources/catalog_remote_data_source.dart';
import '../../features/catalog/data/repositories/catalog_repository_impl.dart';
import '../../features/catalog/domain/repositories/catalog_repository.dart';
import '../../features/catalog/domain/usecases/get_product.dart';
import '../../features/catalog/domain/usecases/get_products.dart';
import '../../features/catalog/domain/usecases/search_products.dart';
import '../../features/catalog/presentation/providers/catalog_provider.dart';

// Cart
import '../../features/cart/presentation/providers/cart_provider.dart';

// Orders
import '../../features/orders/presentation/providers/orders_provider.dart';

class DependencyInjection {
  static late SharedPreferences _sharedPreferences;
  static late firebase_auth.FirebaseAuth _firebaseAuth;
  static late http.Client _httpClient;

  // Repositories
  static late AuthRepository _authRepository;
  static late CatalogRepository _catalogRepository;

  // Use Cases - Auth
  static late SignIn _signIn;
  static late SignUp _signUp;
  static late SignOut _signOut;

  // Use Cases - Catalog
  static late GetProducts _getProducts;
  static late GetProduct _getProduct;
  static late SearchProducts _searchProducts;

  // Providers
  static late AuthProvider authProvider;
  static late CatalogProvider catalogProvider;
  static late CartProvider cartProvider;
  static late OrdersProvider ordersProvider;

  static Future<void> init() async {
    // External dependencies
    _sharedPreferences = await SharedPreferences.getInstance();
    _firebaseAuth = firebase_auth.FirebaseAuth.instance;
    _httpClient = http.Client();

    // Auth setup
    final authRemoteDataSource = AuthRemoteDataSourceImpl(
      firebaseAuth: _firebaseAuth,
    );
    _authRepository = AuthRepositoryImpl(
      remoteDataSource: authRemoteDataSource,
    );
    _signIn = SignIn(_authRepository);
    _signUp = SignUp(_authRepository);
    _signOut = SignOut(_authRepository);
    authProvider = AuthProvider(
      signIn: _signIn,
      signUp: _signUp,
      signOut: _signOut,
      repository: _authRepository,
    );

    // Catalog setup
    final catalogRemoteDataSource = CatalogRemoteDataSourceImpl(
      client: _httpClient,
    );
    final catalogLocalDataSource = CatalogLocalDataSourceImpl(
      sharedPreferences: _sharedPreferences,
    );
    _catalogRepository = CatalogRepositoryImpl(
      remoteDataSource: catalogRemoteDataSource,
      localDataSource: catalogLocalDataSource,
    );
    _getProducts = GetProducts(_catalogRepository);
    _getProduct = GetProduct(_catalogRepository);
    _searchProducts = SearchProducts(_catalogRepository);
    catalogProvider = CatalogProvider(
      getProducts: _getProducts,
      getProduct: _getProduct,
      searchProducts: _searchProducts,
    );

    // Cart setup
    cartProvider = CartProvider();

    // Orders setup
    ordersProvider = OrdersProvider();
  }
}

