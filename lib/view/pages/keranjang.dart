
import 'package:flutter/material.dart';
import 'package:fioke/models/cartitem.dart';
import 'package:fioke/view/component/rekomendasi.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final List<CartItem> _items = [
    CartItem(
      id: 1,
      title: 'Judul produk',
      price: 20000,
      imageUrl: 'https://picsum.photos/seed/teh/200/200',
      selected: false,
      qty: 1,
    ),
    CartItem(
      id: 2,
      title: 'Judul produk',
      price: 200,
      imageUrl: 'https://picsum.photos/seed/susu/200/200',
      selected: false,
      qty: 1,
    ),
    CartItem(
      id: 3,
      title: 'Judul produk',
      price: 200,
      imageUrl: 'https://picsum.photos/seed/susu/200/200',
      selected: false,
      qty: 1,
    ),
  ];

  bool get _allSelected => _items.isNotEmpty && _items.every((e) => e.selected);

  int _discount = 0; // dari voucher
  String? _voucherCode;

  // Hitung total hanya dari item yang tercentang
  int get _subtotalSelected => _items
      .where((e) => e.selected)
      .fold(0, (sum, e) => sum + e.price * e.qty);

  int get _grandTotal => (_subtotalSelected - _discount).clamp(0, 1 << 31);

  String rupiah(int value) {
    // formatter sederhana (tanpa intl) – cukup buat demo
    final s = value.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final idxFromRight = s.length - i;
      buf.write(s[i]);
      if (idxFromRight > 1 && idxFromRight % 3 == 1) {
        buf.write('.'); // kalo lebih dari 99 ribu bakan ada . misal 100.000
      }
    }
    return 'Rp. ${buf.toString()}';
  }

  /* ------------------------------ WIDGETS ------------------------------ */
  @override
  Widget build(BuildContext context) {
    final selectedCount = _items
        .where((e) => e.selected)
        .length; // hitung sebanyak apaa yang nanti dipilih
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade400,
        foregroundColor: Colors.white,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // balik ke home beranda
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Keranjang Anda (${_items.length})', // app bar
          style: const TextStyle(color: Colors.white),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.notifications_none, color: Colors.white),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 140),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PILIH SEMUA + LIST CART
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: _buildSelectAllCard(),
              ),

              // Rekomendasi
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Text(
                  'Produk yang mungkin anda cari',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 12,end: 12),
                child:Rekomendasi() ,
              
              )
            ],
          ),
        ),
      ),

      // VOUCHER BAR + BOTTOM TOTAL
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildVoucherBar(context),
          _buildBottomTotalBar(selectedCount),
        ],
      ),
    );
  }

  /* --------------------------- SECTION WIDGETS -------------------------- */

  Widget _buildSelectAllCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: [
          // Row "Pilih Semua"
          InkWell(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            onTap: () {
              final newVal = !_allSelected;
              setState(() => _items.forEach((e) => e.selected = newVal));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  Checkbox(
                    value: _allSelected,
                    onChanged: (v) => setState(
                      //state kalo di ceklis, bener nanti dia jadi true di _items,
                      () => _items.forEach((e) => e.selected = v ?? false),
                    ), // jadi kepilih semua
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Pilih Semua',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1), // garis di bawah
          // Daftar item
          ..._items
              .map((e) => _buildCartRow(e))
              , //bawahnya pengulangan dari item yg ada di _items
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // -------- INI card keranjang nya --------------
  Widget _buildCartRow(CartItem item) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Checkbox di kiri
          Checkbox(
            value: item.selected,
            onChanged: (v) => setState(
              () => item.selected = v ?? false,
            ), // kalo di ceklis dia nambah
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ), //lengkung
          ),

          // Gambar produk
          Container(
            width: 72,
            height: 72,
            margin: const EdgeInsets.only(right: 12, top: 2),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(item.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Judul + harga
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Judul produk',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade900,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    rupiah(item.price),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),

          // Stepper qty
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _qtyButton(
                //quantity button
                icon: Icons.remove, //min
                onTap: () => setState(() {
                  if (item.qty > 1) {
                    item.qty--; //kalo item lebih dari 1 maka bisa dikurang
                  }
                }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '${item.qty}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              _qtyButton(
                icon: Icons.add, // plus
                onTap: () => setState(() => item.qty++), // nambah
              ),
              const SizedBox(width: 6),
            ],
          ),
        ],
      ),
    );
  }

  Widget _qtyButton({required IconData icon, required VoidCallback onTap}) {
    return InkResponse(
      onTap: onTap,
      radius: 20,
      child: Container(
        // ini buat design button increment nya
        width: 28,
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }
  // ----------------- Grid rekomendasi ------------------

  Widget _buildVoucherBar(BuildContext context) {
    return Material(
      elevation: 6,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(color: Colors.blue.shade50),
        child: Row(
          children: [
            const Icon(Icons.confirmation_num_outlined),
            const SizedBox(width: 8),
            const Text(
              'Voucher',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'masukan kode',
                style: TextStyle(color: Colors.blueGrey),
              ),
            ),
            TextButton.icon(
              onPressed: () => _showVoucherSheet(context),
              icon: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
              label: const Text('Pakai'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomTotalBar(int selectedCount) {
    return Material(
      elevation: 12,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        color: Colors.white,
        child: Row(
          children: [
            // Total
            Expanded(
              child: Container(
                color: Colors.indigo.shade50,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      rupiah(_grandTotal),
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    if (_discount > 0)
                      Text(
                        'Termasuk diskon: -${rupiah(_discount)}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.green,
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Checkout
            Expanded(
              child: InkWell(
                onTap: selectedCount == 0
                    ? null
                    : () {
                        // future: go to payment
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Checkout $selectedCount item, bayar ${rupiah(_grandTotal)}',
                            ),
                          ),
                        );
                      },
                child: Container(
                  height: double.infinity,
                  alignment: Alignment.center,
                  color: selectedCount == 0
                      ? Colors.indigo.shade200
                      : Colors.indigo.shade500,
                  child: const Text(
                    'Check Out',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* ------------------------------ VOUCHER UI ----------------------------- */
  void _showVoucherSheet(BuildContext context) {
    final ctrl = TextEditingController(text: _voucherCode ?? '');
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            top: 8,
            left: 16,
            right: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Masukkan Kode Voucher',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: ctrl,
                decoration: InputDecoration(
                  hintText: 'Contoh: HEMAT10',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        final code = ctrl.text.trim().toUpperCase();
                        int discount = 0;
                        if (code == 'HEMAT10') discount = 10000;
                        setState(() {
                          _voucherCode = code.isEmpty ? null : code;
                          _discount = discount;
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              discount > 0
                                  ? 'Voucher diterapkan: -${rupiah(discount)}'
                                  : 'Kode tidak valid',
                            ),
                          ),
                        );
                      },
                      child: const Text('Terapkan'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

/* ------------------------------ HELPERS -------------------------------- */
