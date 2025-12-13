import '../models/favorite_meal.dart';

class FavoritesService {
  static final List<FavoriteMeal> _favorites = [];

  static List<FavoriteMeal> get favorites => _favorites;

  static bool isFavorite(String id) {
    return _favorites.any((m) => m.id == id);
  }

  static void toggleFavorite(FavoriteMeal meal) {
    if (isFavorite(meal.id)) {
      _favorites.removeWhere((m) => m.id == meal.id);
    } else {
      _favorites.add(meal);
    }
  }
}