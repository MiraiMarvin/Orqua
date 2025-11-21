import 'package:equatable/equatable.dart';
import '../../../cart/domain/entities/cart_item.dart';

class Order extends Equatable {
  final String id;
  final List<CartItem> items;
  final double total;
  final DateTime date;
  final String status;

  const Order({
    required this.id,
    required this.items,
    required this.total,
    required this.date,
    required this.status,
  });

  @override
  List<Object?> get props => [id, items, total, date, status];
}

