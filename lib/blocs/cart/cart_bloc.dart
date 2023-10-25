import 'package:bloc/bloc.dart';
import 'package:coffee_app/model/cart_item.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';



class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartInitial(item: [])) {
    on<CartEventItemAdd>(_onItemAdded);
    on<CartEventItemRemove>(_onItemRemoved);
    on<CartEventCountDecrement>(_onItemCountDecrement);
    on<CartEvenCountIncrement>(_onItemCountIncrement);
  }

  void _onItemAdded(CartEventItemAdd event, Emitter emit) {
    final oldItems = state.item;
    emit(CartLoading(item: state.item));
    if (oldItems.contains(event.item)) {
      final newItems = oldItems.map((item) {
        if (item == event.item) {
          return item.copyWith(quantity: item.quantity + event.item.quantity);
        }
        return item;
      }).toList();
      emit(CartItemAdded(item: newItems));
      return;
    }
    final newList = [...oldItems, event.item];
    emit(CartItemAdded(item: newList));
  }

  void _onItemRemoved(CartEventItemRemove event, Emitter emit) {
    emit(CartLoading(item: state.item));
    final items = [...state.item];
    items.remove(event.item);
    emit(CartItemRemove(item: items));
  }

  void _onItemCountIncrement(CartEvenCountIncrement event, Emitter emit) {
    emit(CartLoading(item: state.item));
    final newItems = state.item.map((item) {
      if (item == event.item) {
        return item.copyWith(quantity: item.quantity + 1);
      }
      return item;
    }).toList();
    emit(CartItemCountIncrement(item: newItems));
  }

  void _onItemCountDecrement(CartEventCountDecrement event, Emitter emit) {
    emit(CartLoading(item: state.item));
    final newItems = state.item.map((item) {
      if (item == event.item) {
        return item.copyWith(quantity: item.quantity - 1);
      }
      return item;
    }).toList();
    emit(CartItemCountDecrement(item: newItems));
  }
}




//
//
// class CartBloc extends Bloc<CartEvent, CartState> {
//   CartBloc() : super(const CartInitial(item: [],)) {
//     on<CartEventItemAdd>(_increment);
//     on<CartEventItemRemove>(_decrement);
//     on<CartEvenCountIncrement>(_countIncrement);
//     on<CartEventCountDecrement>(_countDecrement);
//   }
//
//
//   void _increment(CartEventItemAdd event, Emitter emit) {
//     final oldItem = state.item;
//     emit(CartLoading(item: state.item));
//     if(oldItem.contains(event.item)){
//       final newItem = oldItem.map((item){
//         if(item == event.item){
//           return item.copyWith(quantity: item.quantity + event.item.quantity);
//         }
//         return item;
//       }).toList();
//       emit(CartItemAdded(item: newItem));
//      return ;
//     }
//     final  newList = [...oldItem,event.item];
//     emit(CartItemAdded(item: newList));
//   }
//
//   void _decrement(CartEventItemRemove event, Emitter emit){
//     emit(CartLoading(item: state.item,));
//     final items = [...state.item];
//     items.remove(event.item);
//     emit(CartItemRemove(item: items));
//
//   }
//
//   void _countIncrement(CartEvenCountIncrement event, Emitter emit){
//     emit(CartLoading(item: state.item));
//
//     final listNew = state.item.map((item){
//       if(item == event.item){
//         return item.copyWith(quantity: item.quantity + 1);
//       }
//       return item;
//     }).toList();
//     emit(CartItemCountIncrement(item: listNew));
//   }
//
//   void _countDecrement(CartEventCountDecrement event, Emitter emit){
//     emit(CartLoading(item: state.item));
//     final list = state.item.map((item){
//       if(item == event.item){
//         return item.copyWith(quantity: item.quantity - 1);
//       }
//       return item;
//     }).toList();
//     print("List: ====> ${list}");
//     emit(CartItemCountIncrement(item: list));
//   }
// }
