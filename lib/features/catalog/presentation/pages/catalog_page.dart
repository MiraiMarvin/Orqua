import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:studioflutter/core/theme/orqua_theme.dart';
import 'package:studioflutter/core/constants/orqua_products.dart';
import 'package:studioflutter/core/widgets/pwa_install_button.dart';
import '../providers/catalog_provider.dart';
import '../widgets/product_card.dart';
import '../widgets/category_chip.dart';
import '../widgets/hero_banner.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../cart/presentation/providers/cart_provider.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final _searchController = TextEditingController();
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CatalogProvider>().loadProducts();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OrquaTheme.sand,
      appBar: AppBar(
        title: const Text('ORQUA'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => context.push('/orders'),
          ),
          Consumer<CartProvider>(
            builder: (context, cart, _) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () => context.push('/cart'),
                  ),
                  if (cart.itemCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        decoration: const BoxDecoration(
                          color: OrquaTheme.accentCoral,
                        ),
                        child: Text(
                          '${cart.itemCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await context.read<AuthProvider>().signOutUser();
              if (context.mounted) {
                context.go('/login');
              }
            },
          ),
        ],
      ),
      body: Consumer<CatalogProvider>(
        builder: (context, catalogProvider, _) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: HeroBanner(),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  child: const Center(
                    child: PwaInstallButton(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Column(
                        children: [
                          Text(
                            'FRAICHEUR ET QUALITÉ DE NOS CÔTES',
                            style: TextStyle(
                              color: OrquaTheme.darkGrey.withValues(alpha: 0.6),
                              fontSize: 11,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Recherche
                          TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Rechercher...',
                              prefixIcon: const Icon(Icons.search, size: 20),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.clear, size: 20),
                                onPressed: () {
                                  _searchController.clear();
                                  context.read<CatalogProvider>().loadProducts();
                                  setState(() => _selectedCategory = null);
                                },
                              ),
                            ),
                            onSubmitted: (value) {
                              context.read<CatalogProvider>().search(value);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Catégories (scroll horizontal centré)
              SliverToBoxAdapter(
                child: Container(
                  height: 60,
                  color: Colors.white,
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        children: [
                          CategoryChip(
                            category: 'TOUS',
                            isSelected: _selectedCategory == null,
                            onTap: () {
                              setState(() => _selectedCategory = null);
                              context.read<CatalogProvider>().loadProducts();
                            },
                          ),
                          const SizedBox(width: 8),
                          ...OrquaProducts.categoryShortNames.keys.map((category) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: CategoryChip(
                                category: category,
                                isSelected: _selectedCategory == category,
                                onTap: () {
                                  setState(() => _selectedCategory = category);
                                  context.read<CatalogProvider>().search(category);
                                },
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Divider(height: 1),
              ),
              // Produits
              if (catalogProvider.state == CatalogState.loading)
                const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: OrquaTheme.primaryBlue,
                    ),
                  ),
                )
              else if (catalogProvider.state == CatalogState.error)
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 2,
                          color: OrquaTheme.accentCoral,
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'ERREUR',
                          style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 3,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          catalogProvider.errorMessage,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () => catalogProvider.loadProducts(),
                          child: const Text('RÉESSAYER'),
                        ),
                      ],
                    ),
                  ),
                )
              else if (catalogProvider.products.isEmpty)
                const SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'AUCUN PRODUIT',
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverLayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount;
                      double childAspectRatio;

                      if (constraints.crossAxisExtent > 1200) {
                        crossAxisCount = 4;
                        childAspectRatio = 0.75;
                      } else if (constraints.crossAxisExtent > 800) {
                        crossAxisCount = 3;
                        childAspectRatio = 0.75;
                      } else if (constraints.crossAxisExtent > 600) {
                        crossAxisCount = 2;
                        childAspectRatio = 0.7;
                      } else {
                        crossAxisCount = 2;
                        childAspectRatio = 0.7;
                      }

                      return SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return ProductCard(product: catalogProvider.products[index]);
                          },
                          childCount: catalogProvider.products.length,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: childAspectRatio,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

