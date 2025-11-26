import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/category.dart';
import '../models/meal.dart';
import '../models/meal_detail.dart';

class ApiService {
  static const String baseUrl = "https://www.themealdb.com/api/json/v1/1";

  // Fetch all categories
  static Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse("$baseUrl/categories.php"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List categoriesJson = data['categories'];
      return categoriesJson.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load categories");
    }
  }

  // Fetch meals by category
  static Future<List<Meal>> fetchMealsByCategory(String category) async {
    final response = await http.get(Uri.parse("$baseUrl/filter.php?c=$category"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List mealsJson = data['meals'];
      return mealsJson.map((json) => Meal.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load meals");
    }
  }

  // Search meals by name
  static Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(Uri.parse("$baseUrl/search.php?s=$query"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] == null) return [];
      List mealsJson = data['meals'];
      return mealsJson.map((json) => Meal.fromJson(json)).toList();
    } else {
      throw Exception("Failed to search meals");
    }
  }

  // Fetch meal details
  static Future<MealDetail> fetchMealDetail(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/lookup.php?i=$id"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return MealDetail.fromJson(data['meals'][0]);
    } else {
      throw Exception("Failed to load meal detail");
    }
  }

  // Random meal
  static Future<MealDetail> randomMeal() async {
    final response = await http.get(Uri.parse("$baseUrl/random.php"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return MealDetail.fromJson(data['meals'][0]);
    } else {
      throw Exception("Failed to fetch random meal");
    }
  }
}