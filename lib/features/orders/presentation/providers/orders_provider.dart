import 'package:flutter/foundation.dart';
import '../../domain/entities/order.dart';
import '../../../cart/domain/entities/cart_item.dart';

class OrdersProvider with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => _orders;

  void addOrder(List<CartItem> items, double total) {
    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      items: items,
      total: total,
      date: DateTime.now(),
      status: 'confirmed',
    );
    _orders.insert(0, order);
    notifyListeners();
  }
}

