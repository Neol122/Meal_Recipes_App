import 'package:flutter/material.dart';
import '../models/favorite_meal.dart';
import '../services/favorites_service.dart';

class FavoriteButton extends StatefulWidget {
  final FavoriteMeal meal;
  const FavoriteButton({required this.meal, super.key});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    final isFav =
        FavoritesService.isFavorite(widget.meal.id);

    return IconButton(
      icon: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () {
        setState(() {
          FavoritesService.toggleFavorite(widget.meal);
        });
      },
    );
  }
}