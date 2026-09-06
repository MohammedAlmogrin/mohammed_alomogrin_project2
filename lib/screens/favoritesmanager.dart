import 'package:mohammed_almogrin_project2/models/place_iteme.dart';

class FavoritesManager {
  static final List<PlaceIteme> favoritePlaces = [];

  static bool isFavorite(int pageId) {
    return favoritePlaces.any((item) => item.pageId == pageId);
  }
  static void toggleFavorite(PlaceIteme item) {
    if (isFavorite(item.pageId!)) {
      favoritePlaces.removeWhere((element) => element.pageId == item.pageId);
    } else {
      favoritePlaces.add(item);
    }
  }
}