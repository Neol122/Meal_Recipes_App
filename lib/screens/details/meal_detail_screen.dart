import 'package:flutter/material.dart';
import '../../models/meal_detail.dart';
import 'package:url_launcher/url_launcher.dart';

class MealDetailScreen extends StatelessWidget {
  final MealDetail meal;
  const MealDetailScreen({required this.meal, super.key});

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(meal.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Responsive image with max height and width
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 300, // limits tall images
                    maxWidth: 600,  // prevents stretching on large screens
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      meal.thumbnail,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                meal.name,
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              if (meal.ingredients.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Ingredients:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    ...meal.ingredients.map((e) => Text("• $e")).toList(),
                    const SizedBox(height: 12),
                  ],
                ),
              Text(
                "Instructions:",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                meal.instructions,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              if (meal.youtube != null && meal.youtube!.isNotEmpty)
                ElevatedButton.icon(
                  onPressed: () => _launchURL(meal.youtube!),
                  icon: const Icon(Icons.video_collection),
                  label: const Text("Watch on YouTube"),
                ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
