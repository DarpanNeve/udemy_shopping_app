import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:udemy_shopping_app/data/categories.dart';
import 'package:udemy_shopping_app/models/category.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  var _name = '';
  var _quantity = 1;
  var _category = categories[Categories.vegetables]!;
  var _note = '';
  final url = Uri.https(
      'udem-88794-default-rtdb.europe-west1.firebasedatabase.app',
      'shopping-list.json');

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'ID': DateTime.now().toString(),
            'name': _name,
            'quantity': _quantity,
            'category': _category.name,
            'note': _note,
          }));
      if (response.statusCode == 200 && context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add New Item'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 2 ||
                        value.trim().length >= 50) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: '1',
                  autofocus: true,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.tryParse(value) == null ||
                        int.tryParse(value)! <= 0) {
                      return 'Please enter a quantity';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _quantity = int.parse(value!);
                  },
                ),
                DropdownButtonFormField(
                  value: _category,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: [
                    for (final item in categories.entries)
                      DropdownMenuItem(
                        value: item.value,
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              color: item.value.color,
                            ),
                            const SizedBox(width: 8),
                            Text(item.value.name),
                          ],
                        ),
                      ),
                  ],
                  onChanged: (value) {
                    setState(
                          () {
                        _category = value as Category;
                      },
                    );
                  },
                ),
                TextFormField(
                  autofocus: true,
                  maxLength: 50,
                  decoration: const InputDecoration(labelText: 'Note'),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 2 ||
                        value.trim().length >= 50) {
                      return 'Please enter a note';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _note = value!;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _saveForm,
                      child: const Text('Add'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _formKey.currentState!.reset();
                      },
                      style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Reset'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
