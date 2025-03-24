import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/item.dart';
import '../models/cart_model.dart';

class CartItemWidget extends StatelessWidget {
  final Item item;

  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');

    return ListTile(
      title: Text(item.name),
      subtitle: Text(formatCurrency.format(item.price)),
      trailing: IconButton(
        icon: const Icon(Icons.remove),
        onPressed: () {
          Provider.of<CartModel>(context, listen: false).remove(item);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${item.name} dikurangi dari keranjang"),
              duration: const Duration(seconds: 1),
            ),
          );
        },
      ),
    );
  }
}
