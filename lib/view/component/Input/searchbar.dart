import 'package:flutter/material.dart';
import 'package:fioke/view/pages/hasil_pencarian.dart';
import 'package:fioke/viewmodel/search_viewmodel.dart';
import 'package:provider/provider.dart';

class SearchbarWidget extends StatefulWidget {
  const SearchbarWidget({super.key});
  @override
  State<StatefulWidget> createState() => _SearchbarWidget();
}

class _SearchbarWidget extends State<SearchbarWidget> {
  final TextEditingController _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(
      builder: (context, searchViewModel, child) {
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
                    searchViewModel.isLoading 
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                            ),
                          )
                        : const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _search,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Cari produk...",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        onSubmitted: (value) {
                          searchViewModel.searchProducts(value);
                          
                          // Navigate to results page immediately
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Hasilpencarian(),
                            ),
                          );
                        },
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
      },
    );
  }
}
