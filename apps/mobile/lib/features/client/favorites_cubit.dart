import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesState {
  final Set<int> favoriteIds; // Dishes
  final Set<int> favoriteCookIds; // Cooks

  FavoritesState({Set<int>? favoriteIds, Set<int>? favoriteCookIds})
    : favoriteIds = favoriteIds ?? {},
      favoriteCookIds = favoriteCookIds ?? {};

  bool isFavorite(int dishId) => favoriteIds.contains(dishId);
  bool isFavoriteCook(int cookId) => favoriteCookIds.contains(cookId);
}

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesState());

  void toggleFavorite(int dishId) {
    final newFavorites = Set<int>.from(state.favoriteIds);
    if (newFavorites.contains(dishId)) {
      newFavorites.remove(dishId);
    } else {
      newFavorites.add(dishId);
    }
    emit(
      FavoritesState(
        favoriteIds: newFavorites,
        favoriteCookIds: state.favoriteCookIds,
      ),
    );
  }

  void toggleFavoriteCook(int cookId) {
    final newCookFavorites = Set<int>.from(state.favoriteCookIds);
    if (newCookFavorites.contains(cookId)) {
      newCookFavorites.remove(cookId);
    } else {
      newCookFavorites.add(cookId);
    }
    emit(
      FavoritesState(
        favoriteIds: state.favoriteIds,
        favoriteCookIds: newCookFavorites,
      ),
    );
  }

  void addFavorite(int dishId) {
    if (!state.favoriteIds.contains(dishId)) {
      final newFavorites = Set<int>.from(state.favoriteIds)..add(dishId);
      emit(
        FavoritesState(
          favoriteIds: newFavorites,
          favoriteCookIds: state.favoriteCookIds,
        ),
      );
    }
  }

  void removeFavorite(int dishId) {
    if (state.favoriteIds.contains(dishId)) {
      final newFavorites = Set<int>.from(state.favoriteIds)..remove(dishId);
      emit(
        FavoritesState(
          favoriteIds: newFavorites,
          favoriteCookIds: state.favoriteCookIds,
        ),
      );
    }
  }
}
