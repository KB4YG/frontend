import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController editingController;
  final void Function(String)? onChanged;
  const SearchBar(
      {Key? key, required this.editingController, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: onChanged,
        controller: editingController,
        decoration: const InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)))),
      ),
    );
  }
}
