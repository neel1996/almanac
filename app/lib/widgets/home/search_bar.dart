import 'package:almanac/widgets/book_search_delegate.dart';
import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Search',
        suffixIcon: Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
      onTap: () async {
        await showSearch(context: context, delegate: BookSearchDelegate());
      },
      style: const TextStyle(fontSize: 16, height: 0.5),
    );
  }
}
