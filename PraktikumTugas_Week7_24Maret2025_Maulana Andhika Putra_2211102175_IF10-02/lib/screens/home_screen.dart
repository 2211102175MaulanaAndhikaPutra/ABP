import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/cart_model.dart';
import '../models/item.dart';
import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Ubah daftar item jadi roti
  static const List<Item> availableItems = [
    Item(name: "Roti Tawar", price: 15000),
    Item(name: "Roti Cokelat", price: 20000),
    Item(name: "Roti Keju", price: 22000),
    Item(name: "Roti Sosis", price: 25000), // Tambahan
  ];

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Toko Roti Maull"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: availableItems.length,
        itemBuilder: (context, index) {
          final item = availableItems[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text(formatCurrency.format(item.price)),
            trailing: ElevatedButton(
              onPressed: () {
                _showQuantityDialog(context, item);
              },
              child: const Text("Tambah"),
            ),
          );
        },
      ),
    );
  }

  // Fungsi untuk dialog jumlah barang
  void _showQuantityDialog(BuildContext context, Item item) {
    int quantity = 1;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Tambah ${item.name}"),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (quantity > 1) {
                        setState(() => quantity--);
                      }
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  Text(
                    quantity.toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() => quantity++);
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Batal"),
                ),
                ElevatedButton(
                  onPressed: () {
                    final cart = Provider.of<CartModel>(context, listen: false);
                    for (int i = 0; i < quantity; i++) {
                      cart.add(item);
                    }
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("$quantity ${item.name} ditambahkan ke keranjang"),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Text("Tambah ke Keranjang"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
