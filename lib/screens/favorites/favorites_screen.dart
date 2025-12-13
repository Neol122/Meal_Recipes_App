import 'package:flutter/material.dart';
import '../../services/favorites_service.dart';
import '../details/meal_detail_screen.dart';
import '../../services/api_service.dart';

class FavoritesScreen extends StatelessWidget {
  final String userId;
  const FavoritesScreen({required this.userId,super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = FavoritesService.favorites;

    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Recipes")),
      body: favorites.isEmpty
          ? const Center(child: Text("No favorites yet ❤️"))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final meal = favorites[index];
                return ListTile(
                  leading: Image.network(meal.thumbnail),
                  title: Text(meal.name),
                  onTap: () async {
                    final detail =
                        await ApiService.fetchMealDetail(meal.id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            MealDetailScreen(meal: detail),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
