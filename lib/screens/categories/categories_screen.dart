import 'package:flutter/material.dart';
import '../../models/category.dart';
import '../../services/api_service.dart';
import '../meals/meals_screen.dart';
import '../details/meal_detail_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Category> categories = [];
  List<Category> filtered = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  void loadCategories() async {
    categories = await ApiService.fetchCategories();
    filtered = categories;
    setState(() {
      loading = false;
    });
  }

  void search(String query) {
    setState(() {
      filtered = categories
          .where((cat) =>
              cat.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: () async {
              final meal = await ApiService.randomMeal();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => MealDetailScreen(meal: meal)),
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
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search categories...",
                border: OutlineInputBorder(),
              ),
              onChanged: search,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                const Text(
                  "Random recipe:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.shuffle),
                  onPressed: () async {
                    final meal = await ApiService.randomMeal();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              MealDetailScreen(meal: meal)),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final c = filtered[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network(c.thumbnail, width: 60),
                    title: Text(c.name),
                    subtitle: Text(
                      c.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MealsScreen(category: c.name),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
