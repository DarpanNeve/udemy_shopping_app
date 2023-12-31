

import 'package:udemy_shopping_app/models/category.dart';

class GroceryItem{
  final String id;
  final String name;
  final int quantity;
  final Category category;
  final String note;

  const GroceryItem({
    required this.note,
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });
}