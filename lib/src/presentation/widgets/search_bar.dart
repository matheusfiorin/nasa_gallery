import 'dart:async';

import 'package:flutter/material.dart';

class NasaSearchBar extends StatefulWidget {
  final void Function(String) onSearch;

  const NasaSearchBar({
    super.key,
    required this.onSearch,
  });

  @override
  State<NasaSearchBar> createState() => _NasaSearchBarState();
}

class _NasaSearchBarState extends State<NasaSearchBar> {
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search by title or date...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onChanged: (query) {
          _debouncer.run(() {
            widget.onSearch(query);
          });
        },
      ),
    );
  }
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
