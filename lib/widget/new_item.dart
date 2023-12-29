import 'package:flutter/material.dart';
import 'package:udemy_shopping_app/data/categories.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add New Item'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: '1',
                  autofocus: true,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                ),
                DropdownButtonFormField(
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
                  onChanged: (value) {},
                ),
                TextFormField(
                  autofocus: true,
                  maxLength: 50,
                  decoration: const InputDecoration(labelText: 'Note'),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Add'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
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
