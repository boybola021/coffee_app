part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  final CartItem item;
  const CartEvent({required this.item});
  @override
  List<Object?> get props => [item];
}

class CartEventItemAdd extends CartEvent{
  const CartEventItemAdd({required super.item});
}

class CartEventItemRemove extends CartEvent{
  const CartEventItemRemove({required super.item});
}

class CartEvenCountIncrement extends CartEvent{
  const CartEvenCountIncrement({required super.item});
}

class CartEventCountDecrement extends CartEvent{
  const CartEventCountDecrement({required super.item});
}
