import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Topnav extends StatelessWidget {
  const Topnav({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            // Search Bar
            Expanded(
              child: Container(
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
                          hintText: "Teh botol Sosro",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/kategori');
                    },
                    child: SvgPicture.asset('svg/notifiication.svg'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/keranjang');
                    },
                    child: SvgPicture.asset('svg/cart.svg'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
