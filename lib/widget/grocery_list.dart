import 'package:flutter/material.dart';

import '../data/dummy_items.dart';
import '../models/grocery_item.dart';
import 'new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  @override
  Widget build(BuildContext context) {
    Widget content = Center(child:Text("No Items",style: Theme.of(context).textTheme.titleLarge,));
    if (groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (context, index) {
          final item = groceryItems[index];
          return Dismissible(
            key: Key(item.id),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {
              setState(() {
                groceryItems.removeAt(index);
              });

            },

            child: ListTile(
              leading: ExcludeSemantics(
                child: CircleAvatar(
                  backgroundColor: item.category.color,
                  child: Text(item.name[0]),
                ),
              ),
              title: Text(item.name),
              subtitle: Text(item.note),
              trailing: Text('${item.quantity}'),
            ),
          );
        },
      );
    }

    void addItem() async {
      final newItem = await Navigator.of(context).push<GroceryItem>(
        MaterialPageRoute(
          builder: (context) => const NewItem(),
        ),
      );
      if (newItem == null) {
        return;
      }
      setState(() {
        groceryItems.add(newItem);
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Groceries'), actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: addItem,
        ),
      ]),
      body: Center(
        child: content,
      ),
    );
  }
}