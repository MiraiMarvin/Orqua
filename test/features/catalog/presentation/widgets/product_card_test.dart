import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studioflutter/features/catalog/domain/entities/product.dart';
import 'package:studioflutter/features/catalog/presentation/widgets/product_card.dart';
import 'package:provider/provider.dart';
import 'package:studioflutter/features/cart/presentation/providers/cart_provider.dart';

void main() {
  testWidgets('ProductCard displays product information', (WidgetTester tester) async {
    const testProduct = Product(
      id: 1,
      title: 'Test Product',
      price: 19.99,
      description: 'Test description',
      category: 'test',
      thumbnail: 'https://via.placeholder.com/150',
      images: ['https://via.placeholder.com/150'],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChangeNotifierProvider(
            create: (_) => CartProvider(),
            child: const ProductCard(product: testProduct),
          ),
        ),
      ),
    );

    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('19.99 €'), findsOneWidget);
    expect(find.text('Ajouter'), findsOneWidget);
  });

  testWidgets('ProductCard add to cart button works', (WidgetTester tester) async {
    const testProduct = Product(
      id: 1,
      title: 'Test Product',
      price: 19.99,
      description: 'Test description',
      category: 'test',
      thumbnail: 'https://via.placeholder.com/150',
      images: ['https://via.placeholder.com/150'],
    );

    final cartProvider = CartProvider();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChangeNotifierProvider.value(
            value: cartProvider,
            child: const ProductCard(product: testProduct),
          ),
        ),
      ),
    );

    expect(cartProvider.items.length, 0);

    await tester.tap(find.text('Ajouter'));
    await tester.pump();

    expect(cartProvider.items.length, 1);
    expect(cartProvider.items.first.product.id, 1);
  });
}

