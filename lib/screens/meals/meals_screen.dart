import 'package:flutter/material.dart';
import '../../models/meal.dart';
import '../../services/api_service.dart';
import '../details/meal_detail_screen.dart';

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

  void loadMeals() async {
    meals = await ApiService.fetchMealsByCategory(widget.category);
    filtered = meals;
    setState(() {
      loading = false;
    });
  }

  void search(String query) async {
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
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: "Search meals...",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: search,
                  ),
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // Responsive column count
                      int crossAxisCount = constraints.maxWidth > 1000
                          ? 4
                          : constraints.maxWidth > 700
                              ? 3
                              : 2;

                      return GridView.builder(
                        padding: const EdgeInsets.all(8),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: 3 / 4, // width / height ratio
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final meal = filtered[index];
                          return GestureDetector(
                            onTap: () async {
                              final mealDetail =
                                  await ApiService.fetchMealDetail(meal.id);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      MealDetailScreen(meal: mealDetail),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1, // makes image square
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(10)),
                                      child: Image.network(
                                        meal.thumbnail,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      meal.name,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
