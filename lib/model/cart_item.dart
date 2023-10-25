

import 'package:coffee_app/model/coffiee_model.dart';
import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final int id;
  final CoffeeModel coffeeModel;
  final CoffeeSize size;
  final int quantity;
  final double total;

  const CartItem({
    required this.id,
    required this.coffeeModel,
    required this.size,
    required this.quantity,
    required this.total,
  });

  @override
  String toString() {
    return "id: $id, title: ${coffeeModel.title} quantity: $quantity, size: $size total: $total";
  }

  CartItem copyWith({
    CoffeeSize? size,
    int? quantity,
    double? total,
  }) {
    return CartItem(
        id: id,
        coffeeModel: coffeeModel,
        size: size ?? this.size,
        quantity: quantity ?? this.quantity,
        total: total ?? this.total);
  }

  @override
  List<Object?> get props => [id, coffeeModel, size];
}

enum CoffeeSize {
  min(portion: "114"),
  med(portion: "140"),
  max(portion: "227");

  const CoffeeSize({required this.portion});
  final String portion;
}