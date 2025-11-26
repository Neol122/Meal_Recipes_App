class MealDetail {
  final String id;
  final String name;
  final String instructions;
  final String thumbnail;
  final String? youtube;
  final List<String> ingredients;

  MealDetail({
    required this.id,
    required this.name,
    required this.instructions,
    required this.thumbnail, 
    required this.ingredients,
    this.youtube,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];

    for (int i = 1; i <= 20; i++) {
      String? ingredient = json['strIngredient$i'];
      String? measure = json['strMeasure$i'];

      if (ingredient != null && ingredient.isNotEmpty) {
        ingredients.add("$ingredient - ${measure ?? ''}".trim());
      }
    }

    return MealDetail(
      id: json['idMeal'],
      name: json['strMeal'],
      instructions: json['strInstructions'],
      thumbnail: json['strMealThumb'],
      youtube: json['strYoutube'],
      ingredients: ingredients,
    );
  }
}