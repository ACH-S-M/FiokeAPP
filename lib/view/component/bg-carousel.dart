import 'dart:async';
import 'package:flutter/material.dart';

class BgCarousel extends StatefulWidget {
  final List<String> images;
  final double height;

  const BgCarousel({super.key, required this.images, this.height = 150});

  @override
  _BannerCarouselState createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BgCarousel> {
  late PageController _controller;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: _currentPage);

    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < widget.images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _controller.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.bounceInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius:  BorderRadius.circular(15),
            child: Image.asset(widget.images[index], fit: BoxFit.fill),
          );
        },
      ),
    );
  }
}
