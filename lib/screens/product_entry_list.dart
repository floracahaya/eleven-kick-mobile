import 'package:flutter/material.dart';
import 'package:elevenkick/models/product_entry.dart';
import 'package:elevenkick/widgets/left_drawer.dart';
import 'package:elevenkick/screens/product_detail.dart';
import 'package:elevenkick/widgets/product_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductEntryListPage extends StatefulWidget {
  const ProductEntryListPage({super.key});

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  Future<List<ProductEntry>> fetchAllProducts(CookieRequest request) async {
    try {
      final response = await request.get('http://localhost:8000/all-products/');
      debugPrint('DEBUG RAW RESPONSE: $response');

      // jika backend mengembalikan HTML (login page), jangan crash
      if (response is String && response.trim().startsWith('<')) {
        debugPrint('Backend returned HTML. Showing empty list.');
        return []; // tampilkan list kosong
      }

      List<ProductEntry> allProducts = [];

      if (response is List) {
        for (var d in response) {
          if (d is Map) {
            // skip produk yang usernya null
            if (d['user_id'] == null || d['user_username'] == null) continue;
            final m = Map<String, dynamic>.from(d.cast<String, dynamic>());
            allProducts.add(ProductEntry.fromJson(m));
          }
        }
      } else if (response is Map && response['data'] is List) {
        for (var d in response['data']) {
          if (d is Map) {
            if (d['user_id'] == null || d['user_username'] == null) continue;
            final m = Map<String, dynamic>.from(d.cast<String, dynamic>());
            allProducts.add(ProductEntry.fromJson(m));
          }
        }
      }

      debugPrint('Fetched ${allProducts.length} products');
      return allProducts;
    } catch (e) {
      debugPrint('Error fetching all products: $e');
      return []; // jangan crash, tampilkan list kosong
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(title: const Text('All Products')),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<ProductEntry>>(
        future: fetchAllProducts(request),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Error loading products'),
                  const SizedBox(height: 8),
                  Text('Error: ${snapshot.error}', textAlign: TextAlign.center),
                ],
              ),
            );
          }

          final products = snapshot.data ?? [];

          if (products.isEmpty) {
            return const Center(
              child: Text(
                'No products available.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (_, index) {
              final product = products[index];
              return ProductEntryCard(
                product: product,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(product: product),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
