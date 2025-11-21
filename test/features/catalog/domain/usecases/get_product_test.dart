import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:studioflutter/features/catalog/domain/entities/product.dart';
import 'package:studioflutter/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:studioflutter/features/catalog/domain/usecases/get_product.dart';

import 'get_product_test.mocks.dart';

@GenerateMocks([CatalogRepository])
void main() {
  late GetProduct usecase;
  late MockCatalogRepository mockRepository;

  setUp(() {
    mockRepository = MockCatalogRepository();
    usecase = GetProduct(mockRepository);
  });

  const tProductId = 1;
  const tProduct = Product(
    id: 1,
    title: 'Test Product',
    price: 10.0,
    description: 'Test description',
    category: 'test',
    thumbnail: 'https://test.com/image.jpg',
    images: ['https://test.com/image.jpg'],
  );

  test('should get product by id from the repository', () async {
    // arrange
    when(mockRepository.getProduct(any))
        .thenAnswer((_) async => const Right(tProduct));

    // act
    final result = await usecase(const GetProductParams(id: tProductId));

    // assert
    expect(result, const Right(tProduct));
    verify(mockRepository.getProduct(tProductId));
    verifyNoMoreInteractions(mockRepository);
  });
}

