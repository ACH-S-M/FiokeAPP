import 'package:flutter/material.dart';

class DeskripsiComponent extends StatelessWidget {
  final String deskripsi;
  final String judul;
  final List<String> poin;
  const DeskripsiComponent({required this.judul,required this.deskripsi,required this.poin, super.key,});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.all(12),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(judul,style: TextStyle(fontSize: 22),),
              Container(
                margin: EdgeInsets.fromLTRB(0, 30, 12, 12),
                child:  Column(
                  children: [
                    Text(deskripsi),
                    Column(
                      children: poin.map((e) => _Bullet(text: e)).toList(),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

}
class _Bullet extends StatelessWidget {
  final String text;
  const _Bullet({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("•  "),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}