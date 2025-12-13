import 'package:flutter/material.dart';
import '../../models/meal.dart';
import '../../models/favorite_meal.dart';
import '../../services/api_service.dart';
import '../../widgets/favorite_button.dart';
import '../details/meal_detail_screen.dart';
import '../../services/firestore_service.dart';
import '../favorites/favorites_screen.dart';



class MealsScreen extends StatefulWidget {
  final String category;
  const MealsScreen({required this.category, super.key});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  List<Meal> meals = [];
  List<Meal> filtered = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadMeals();
  }

  Future<void> loadMeals() async {
    meals = await ApiService.fetchMealsByCategory(widget.category);
    filtered = meals;
    setState(() => loading = false);
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      filtered = meals;
    } else {
      filtered = await ApiService.searchMeals(query);
    }
    setState(() {});
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.category),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FavoritesScreen(userId: 'YOUR_USER_ID'),
              ),
            );
          },
        ),
      ],
    ),
    body: loading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search meals...',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: search,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.78,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final meal = filtered[index];

                    return GestureDetector(
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
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: ClipRRect(
                                      borderRadius:
                                          const BorderRadius.vertical(
                                        top: Radius.circular(12),
                                      ),
                                      child: Image.network(
                                        meal.thumbnail,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 6,
                                    right: 6,
                                    child: FavoriteButton(
                                      meal: FavoriteMeal(
                                        id: meal.id,
                                        name: meal.name,
                                        thumbnail: meal.thumbnail,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                meal.name,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
  );
}}