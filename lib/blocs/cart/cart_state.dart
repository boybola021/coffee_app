part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  final List<CartItem> item;
  
  const CartState({required this.item,});
  @override
  List<Object?> get props => [item];

}


class CartInitial extends CartState{
  const CartInitial({required super.item, });
}


class CartLoading extends CartState{
  const  CartLoading({required super.item,});
}


class CartItemRemove extends CartState{
  const CartItemRemove({required super.item,});
}


class CartItemAdded extends CartState{
  const CartItemAdded({required super.item,});
}


class CartItemCountIncrement extends CartState{
  const CartItemCountIncrement({required super.item,});
}

class CartItemCountDecrement extends CartState{
  const CartItemCountDecrement({required super.item,});
}

