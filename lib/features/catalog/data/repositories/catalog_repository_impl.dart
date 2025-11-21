import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/catalog_repository.dart';
import '../datasources/catalog_local_data_source.dart';
import '../datasources/catalog_remote_data_source.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  final CatalogRemoteDataSource remoteDataSource;
  final CatalogLocalDataSource localDataSource;

  CatalogRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final remoteProducts = await remoteDataSource.getProducts();
      await localDataSource.cacheProducts(remoteProducts);
      return Right(remoteProducts);
    } on ServerException catch (e) {
      try {
        final cachedProducts = await localDataSource.getCachedProducts();
        return Right(cachedProducts);
      } on CacheException {
        return Left(ServerFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Product>> getProduct(int id) async {
    try {
      final product = await remoteDataSource.getProduct(id);
      await localDataSource.cacheProduct(product);
      return Right(product);
    } on ServerException catch (e) {
      try {
        final cachedProduct = await localDataSource.getCachedProduct(id);
        return Right(cachedProduct);
      } on CacheException {
        return Left(ServerFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Product>>> searchProducts(String query) async {
    try {
      final products = await remoteDataSource.getProducts();
      final filtered = products
          .where((p) =>
              p.title.toLowerCase().contains(query.toLowerCase()) ||
              p.category.toLowerCase().contains(query.toLowerCase()))
          .toList();
      return Right(filtered);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}

