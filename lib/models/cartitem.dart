class CartItem {
  final int id;
  final String title;
  final int price; // in rupiah
  final String imageUrl;
  int qty;
  bool selected;
  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.qty = 1,
    this.selected = false,
  });
}
