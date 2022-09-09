import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../models/cat_model.dart';

class CustomItem extends StatefulWidget {
  final Cat cat;
  const CustomItem({Key? key, required this.cat}) : super(key: key);

  @override
  State<CustomItem> createState() => _CustomItemState();
}

class _CustomItemState extends State<CustomItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Race: ${widget.cat.race} | Name: ${widget.cat.name} '),
      onLongPress: () {
        setState(() {
          DatabaseHelper.instance.delete(widget.cat.id!);
        });
      },
    );
  }
}