import 'package:flutter/material.dart';
import 'package:elevenkick/screens/add_product_page.dart';
import 'package:elevenkick/screens/product_entry_list.dart';
import 'package:elevenkick/screens/my_product_list.dart';
import 'package:elevenkick/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage({required this.name, required this.icon, required this.color});
}

class ItemCard extends StatelessWidget {
  // Menampilkan kartu dengan ikon dan nama.

  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Material(
      // Menentukan warna latar belakang dari tema aplikasi.
      color: item.color,
      // Membuat sudut kartu melengkung.
      borderRadius: BorderRadius.circular(12),

      child: InkWell(
        // Aksi ketika kartu ditekan.
        // Area responsif terhadap sentuhan
        onTap: () async {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!"),
              ),
            );

          // Navigate ke route yang sesuai (tergantung jenis tombol)
          if (item.name == "Add Product") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddProductPage()),
            );
          } else if (item.name == "All Products") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductEntryListPage(),
              ),
            );
          } else if (item.name == "My Products") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyProductListPage(),
              ),
            );
          } else if (item.name == "Logout") {
            final response = await request.logout(
              "http://localhost:8000/auth/logout/",
            );
            String message = response["message"];
            if (context.mounted) {
              if (response['status']) {
                String uname = response["username"];
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("$message See you again, $uname.")),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              } else {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(message)));
              }
            }
          }
        },
        // Container untuk menyimpan Icon dan Text
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              // Menyusun ikon dan teks di tengah kartu.
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30.0),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
