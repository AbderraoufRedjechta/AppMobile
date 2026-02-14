import 'package:flutter_bloc/flutter_bloc.dart';

class CartState {
  final List<Map<String, dynamic>> items;

  CartState({this.items = const []});

  int get total => items.fold(0, (sum, item) => sum + (item['price'] as int));
}

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState());

  void addToCart(Map<String, dynamic> dish) {
    emit(CartState(items: [...state.items, dish]));
  }

  void removeFromCart(Map<String, dynamic> dish) {
    final items = [...state.items];
    items.remove(dish);
    emit(CartState(items: items));
  }

  void clearCart() {
    emit(CartState());
  }
}
