import 'package:flutter/material.dart';

class SearchbarWidget extends StatefulWidget {
  const SearchbarWidget({super.key});
  @override
  State<StatefulWidget> createState() => _SearchbarWidget();
}

class _SearchbarWidget extends State<SearchbarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              splashRadius: 20,
            ),
            // Search Bar
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Cari produk...",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
