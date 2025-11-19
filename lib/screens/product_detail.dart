import 'package:flutter/material.dart';
import 'package:elevenkick/models/product_entry.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntry product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            if (product.thumbnail.isNotEmpty)
              Image.network(
                'http://localhost:8000/proxy-image/?url=${Uri.encodeComponent(product.thumbnail)}',
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 250,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.broken_image, size: 50),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Featured Badge
                  if (product.isFeatured)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: const Text(
                        'FEATURED',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  // Product Name
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Category
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          product.category.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo.shade700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // User username
                      Text(
                        "By: ${product.userUsername}",
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Price
                  Text(
                    "Rp ${product.price}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // ID & User ID
                  Text(
                    "ID: ${product.id}",
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  Text(
                    "User ID: ${product.userId}",
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const Divider(height: 32),
                  // Description
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16, height: 1.6),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 24),
                  // Back button
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Kembali ke Daftar Item'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
