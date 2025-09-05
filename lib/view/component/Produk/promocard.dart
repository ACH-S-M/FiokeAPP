import 'package:flutter/material.dart';

class Promocard extends StatefulWidget {
  final String gambar;
  final String nama;
  final String harga;
  const Promocard({
    super.key,
    required this.gambar,
    required this.nama,
    required this.harga,
  });
  @override
  State<StatefulWidget> createState() => _Promocard();
}

class _Promocard extends State<Promocard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24),
      width: MediaQuery.of(context).size.width * 0.3,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Image.asset(
              widget.gambar,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.18,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    widget.harga,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.directional(top: 8, bottom: 8),
                  child: ProgressIndicatorTheme(
                    data: ProgressIndicatorThemeData(color: Colors.green),
                    child: LinearProgressIndicator(value: 0.7, minHeight: 5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
