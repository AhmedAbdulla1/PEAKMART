import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReorderableListWithApi extends StatefulWidget {
  @override
  _ReorderableListWithApiState createState() => _ReorderableListWithApiState();
}

class _ReorderableListWithApiState extends State<ReorderableListWithApi> {
  List<String> items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  // Fetch initial items from API
  Future<void> fetchItems() async {
    // final response = await http.get(Uri.parse('https://example.com/api/items'));
    // if (response.statusCode == 200) {
      setState(() {
        items = ["items",'items','items'];
        isLoading = false;
      });
    // } else {
    //   throw Exception('Failed to load items');
    // }
  }

  // Send updated order to API
  Future<void> updateOrder(List<String> updatedItems) async {
    final response = await http.post(
      Uri.parse('https://example.com/api/update-order'),
      body: json.encode(updatedItems),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      // Success: Update UI with the new order
      setState(() {
        items = updatedItems;
      });
    } else {
      throw Exception('Failed to update order');
    }
  }

  // Handle reordering
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final item = items.removeAt(oldIndex);
      items.insert(newIndex, item);
    });

    // Send updated order to API
    updateOrder(items);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : ReorderableListView(
      shrinkWrap: true,
            onReorder: _onReorder,
            children: [
              for (int i = 0; i < items.length; i++)
                AnimatedListItem(
                  key: Key('$i'),
                  item: items[i],
                  index: i,
                ),
            ],
          );
  }
}

// Custom animated list item
class AnimatedListItem extends StatelessWidget {
  final String item;
  final int index;

  const AnimatedListItem({
    required Key key,
    required this.item,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      key: key,
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        title: Text(item),
        trailing: Icon(Icons.drag_handle),
      ),
    );
  }
}
