import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:studioflutter/features/catalog/domain/entities/product.dart';
import 'package:studioflutter/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:studioflutter/features/catalog/domain/usecases/search_products.dart';

import 'search_products_test.mocks.dart';

@GenerateMocks([CatalogRepository])
void main() {
  late SearchProducts usecase;
  late MockCatalogRepository mockRepository;

  setUp(() {
    mockRepository = MockCatalogRepository();
    usecase = SearchProducts(mockRepository);
  });

  const tQuery = 'test';
  const tProduct = Product(
    id: 1,
    title: 'Test Product',
    price: 10.0,
    description: 'Test description',
    category: 'test',
    thumbnail: 'https://test.com/image.jpg',
    images: ['https://test.com/image.jpg'],
  );

  test('should search products from the repository', () async {
    // arrange
    when(mockRepository.searchProducts(any))
        .thenAnswer((_) async => const Right([tProduct]));

    // act
    final result = await usecase(const SearchProductsParams(query: tQuery));

    // assert
    expect(result, const Right([tProduct]));
    verify(mockRepository.searchProducts(tQuery));
    verifyNoMoreInteractions(mockRepository);
  });
}

