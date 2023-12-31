import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data/categories.dart';
import '../models/grocery_item.dart';
import 'new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> groceryItems = [];
  var _isLoading = true;
  String error='No Items';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  _loadData() async {
    final url = Uri.https(
        'udem-88794-default-rtdb.europe-west1.firebasedatabase.app',
        'shopping-list.json');
    final response = await http.get(url);
    print('the response body is  ${response.body}');
    if (response.body.isEmpty || response.statusCode != 200 || response.body == null) {
      setState(() {
        _isLoading = false;
        error="Fail to Fetch";
      });
      return;
    }
    setState(() {
      _isLoading = false;
    });
    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> loadedList = [];
    for (final item in listData.entries) {
      loadedList.add(GroceryItem(
        id: item.key,
        name: item.value['name'],
        quantity: item.value['quantity'],
        category: categories.entries
            .firstWhere(
                (element) => element.value.name == item.value['category'])
            .value,
        note: item.value['note'],
      ));
    }
    setState(
      () {
        groceryItems.clear();
        groceryItems.addAll(loadedList);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    void addItem() async {
      final newItem = await Navigator.of(context).push<GroceryItem>(
        MaterialPageRoute(
          builder: (context) => const NewItem(),
        ),
      );
      if (newItem != null) {
        setState(() {
          groceryItems.add(newItem);
        });
      }
    }

    Widget content = Center(
        child: Text(
      error,
      style: Theme.of(context).textTheme.titleLarge,
    ));
    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }
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