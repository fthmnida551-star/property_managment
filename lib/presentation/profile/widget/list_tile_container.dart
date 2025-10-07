import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListTileContainer extends StatefulWidget {
  final String text;
  const ListTileContainer({super.key,required this.text});

  @override
  State<ListTileContainer> createState() => _ListTileContainerState();
}

class _ListTileContainerState extends State<ListTileContainer> {
  @override
  Widget build(BuildContext context) {
    return  ListTile(
            title:Text(widget.text),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          );
  }
}