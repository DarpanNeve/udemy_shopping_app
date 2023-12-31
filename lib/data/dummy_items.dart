

import 'package:udemy_shopping_app/data/categories.dart';
import 'package:udemy_shopping_app/models/category.dart';

import '../models/grocery_item.dart';

final groceryItems = [
  GroceryItem(
      id: 'a',
      name: 'Milk',
      quantity: 1,
      category: categories[Categories.dairy]!
  ,note: '2% milk'),
  GroceryItem(
      id: 'b',
      name: 'Bananas',
      quantity: 5,
      category: categories[Categories.fruit]!,
      note: 'Ripe bananas only'),
  GroceryItem(
      id: 'c',
      name: 'Onions',
      quantity: 1,
      category: categories[Categories.meat]!,
      note: 'Yellow onions only'),
];