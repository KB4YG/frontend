import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController editingController;
  final void Function(String)? onChanged;
  final String? hintText;
  const SearchBar(
      {Key? key,
      required this.editingController,
      required this.onChanged,
      this.hintText = 'Search'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: TextField(
        onChanged: onChanged,
        controller: editingController,
        decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: const Icon(Icons.search),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)))),
      ),
    );
  }
}
