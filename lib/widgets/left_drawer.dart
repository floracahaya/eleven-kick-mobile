import 'package:flutter/material.dart';
import 'package:elevenkick/screens/my_product_list.dart';
import 'package:elevenkick/screens/add_product_page.dart';
import 'package:elevenkick/screens/product_entry_list.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            // Bagian drawer header
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              children: [
                Text(
                  'ElevenKick',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Seluruh produk olahraga kualitas terbaik ada di sini!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            // Navigate back to the first route (home) without importing main.dart
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
          ListTile(
            leading: const Icon(Icons.post_add),
            title: const Text('Add Product'),
            // Redirect to AddProductPage
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AddProductPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.view_list),
            title: const Text('All Products'),
            onTap: () {
              // Route to product list page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductEntryListPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.folder_special),
            title: const Text('My Product List'),
            onTap: () {
              // Route to product list page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyProductListPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
