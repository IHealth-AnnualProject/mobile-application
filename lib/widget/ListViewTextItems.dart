import 'package:betsbi/model/item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListViewTextItems extends StatefulWidget {
  final List<Item> items;

  ListViewTextItems(this.items);

  @override
  _ListViewTextItemsState createState() => _ListViewTextItemsState();

}

class _ListViewTextItemsState extends State<ListViewTextItems> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: this.widget.items.length,
      itemBuilder: (BuildContext context, int index) {
        return Center(
          child: Text('${this.widget.items[index].content} - ${this.widget.items[index].content}'),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

}