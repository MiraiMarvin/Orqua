import 'package:dartz/dartz.dart';
}
  });
    verifyNoMoreInteractions(mockRepository);
    verify(mockRepository.getProducts());
    expect(result, const Right([tProduct]));
    // assert

    final result = await usecase(NoParams());
    // act

        .thenAnswer((_) async => const Right([tProduct]));
    when(mockRepository.getProducts())
    // arrange
  test('should get products from the repository', () async {

  );
    images: ['https://test.com/image.jpg'],
    thumbnail: 'https://test.com/image.jpg',
    category: 'test',
    description: 'Test description',
    price: 10.0,
    title: 'Test Product',
    id: 1,
  const tProduct = Product(

  });
    usecase = GetProducts(mockRepository);
    mockRepository = MockCatalogRepository();
  setUp(() {

  late MockCatalogRepository mockRepository;
  late GetProducts usecase;
void main() {
@GenerateMocks([CatalogRepository])

import 'get_products_test.mocks.dart';

import 'package:studioflutter/features/catalog/domain/usecases/get_products.dart';
import 'package:studioflutter/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:studioflutter/features/catalog/domain/entities/product.dart';
import 'package:studioflutter/core/usecases/usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

