import 'package:flutter/material.dart';
import 'package:elevenkick/models/product_entry.dart';
import 'package:elevenkick/widgets/product_entry_card.dart';
import 'package:elevenkick/screens/product_detail.dart';
import 'package:elevenkick/widgets/left_drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({super.key});

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  Future<List<ProductEntry>> fetchProducts(BuildContext context) async {
    final request = Provider.of<CookieRequest>(context, listen: false);
    if (request.loggedIn) {
      // Jika login, fetch dari /my-products/ pakai CookieRequest
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
          if (d is Map<String, dynamic>) {
            if (d.containsKey('id') && d['id'] != null && d['id'] is! String) {
              d['id'] = d['id'].toString();
            }
            try {
              myProducts.add(ProductEntry.fromJson(d));
            } catch (_) {}
          }
        }
      }
      return myProducts;
    } else {
      // Jika belum login, fetch dari /all-products/ pakai http
      final url = Uri.parse('http://localhost:8000/all-products/');
      final response = await http.get(url);
      if (response.statusCode != 200) {
        throw Exception('Failed to load products: \\${response.statusCode}');
      }
      final List<dynamic> payload = jsonDecode(response.body);
      final products = <ProductEntry>[];
      for (final d in payload) {
        if (d is Map<String, dynamic>) {
          if (d['user_id'] == null || d['user_username'] == null) continue;
          if (d.containsKey('id') && d['id'] != null && d['id'] is! String) {
            d['id'] = d['id'].toString();
          }
          try {
            products.add(ProductEntry.fromJson(d));
          } catch (e) {
            debugPrint('Skip malformed product: $e');
          }
        }
      }
      return products;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Produk')),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<ProductEntry>>(
        future: fetchProducts(context),
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
                  const SizedBox(height: 16),
                  Text('${snapshot.error}', textAlign: TextAlign.center),
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
