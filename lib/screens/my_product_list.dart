import 'package:flutter/material.dart';
import 'package:elevenkick/models/product_entry.dart';
import 'package:elevenkick/widgets/left_drawer.dart';
import 'package:elevenkick/screens/product_detail.dart';
import 'package:elevenkick/widgets/product_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class MyProductListPage extends StatefulWidget {
  const MyProductListPage({super.key});

  @override
  State<MyProductListPage> createState() => _MyProductListPageState();
}

class _MyProductListPageState extends State<MyProductListPage> {
  Future<List<ProductEntry>> fetchMyProducts(CookieRequest request) async {
    try {
      // Fetch user's products from the my-products endpoint
      final response = await request.get('http://localhost:8000/my-products/');

      // Guard HTML
      if (response is String && response.trim().startsWith('<')) {
        throw Exception('Backend returned HTML, not JSON. Are you logged in?');
      }

      // Normalize payload
      dynamic payload = response;
      if (payload is Map) {
        if (payload['data'] is List) payload = payload['data'];
        if (payload['results'] is List) payload = payload['results'];
      }

      final List<ProductEntry> myProducts = [];
      if (payload is List) {
        for (final d in payload) {
          if (d is Map) {
            final m = Map<String, dynamic>.from(d);
            if (m.containsKey('userId') && !m.containsKey('user_id')) {
              m['user_id'] = m['userId'];
            }
            if (m.containsKey('userUsername') &&
                !m.containsKey('user_username')) {
              m['user_username'] = m['userUsername'];
            }
            if (m.containsKey('dateAdded') && !m.containsKey('date_added')) {
              m['date_added'] = m['dateAdded'];
            }
            if (m.containsKey('isFeatured') && !m.containsKey('is_featured')) {
              m['is_featured'] = m['isFeatured'];
            }
            // Ensure id is a String to satisfy model field type
            if (m.containsKey('id') && m['id'] != null && m['id'] is! String) {
              m['id'] = m['id'].toString();
            }
            try {
              myProducts.add(ProductEntry.fromJson(m));
            } catch (_) {}
          }
        }
      }

      debugPrint('Fetched ${myProducts.length} my products');
      return myProducts;
    } catch (e) {
      debugPrint('Error fetching my products: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(title: const Text('My Products')),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchMyProducts(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Error loading products'),
                  const SizedBox(height: 16),
                  Text('${snapshot.error}'),
                ],
              ),
            );
          }

          final products = snapshot.data ?? [];

          if (products.isEmpty) {
            return const Center(
              child: Text(
                'You have no products yet.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (_, index) => ProductEntryCard(
              product: products[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailPage(product: products[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
