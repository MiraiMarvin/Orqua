import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/orders_provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes commandes'),
      ),
      body: Consumer<OrdersProvider>(
        builder: (context, ordersProvider, _) {
          if (ordersProvider.orders.isEmpty) {
            return const Center(
              child: Text('Aucune commande'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: ordersProvider.orders.length,
            itemBuilder: (context, index) {
              final order = ordersProvider.orders[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ExpansionTile(
                  title: Text('Commande #${order.id}'),
                  subtitle: Text(
                    DateFormat('dd/MM/yyyy HH:mm').format(order.date),
                  ),
                  trailing: Text(
                    '${order.total.toStringAsFixed(2)} €',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Statut: ${order.status}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Text('Produits:'),
                          ...order.items.map((item) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text('${item.product.title} x${item.quantity}'),
                                    ),
                                    Text('${item.totalPrice.toStringAsFixed(2)} €'),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

