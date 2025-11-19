import 'package:flutter/material.dart';

/// - All Products (blue)
/// - My Products (green)
/// - Create Product (red)

class ProductActionMenu extends StatelessWidget {
  final VoidCallback? onAll;
  final VoidCallback? onMine;
  final VoidCallback? onCreate;

  const ProductActionMenu({super.key, this.onAll, this.onMine, this.onCreate});

  void _showDefaultSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  Widget _largeCard({
    required BuildContext context,
    required Color color,
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap:
            onTap ??
            () => _showDefaultSnackbar(
              context,
              'Kamu telah menekan tombol $label',
            ),
        child: Container(
          width: 140,
          height: 140,
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white, size: 40),
                const SizedBox(height: 12),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        const Text(
          'Welcome to ElevenKick!',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 8),
              _largeCard(
                context: context,
                color: Colors.blue,
                icon: Icons.list,
                label: 'All Products',
                onTap: onAll,
              ),
              const SizedBox(width: 12),
              _largeCard(
                context: context,
                color: Colors.green,
                icon: Icons.shopping_bag,
                label: 'My Products',
                onTap: onMine,
              ),
              const SizedBox(width: 12),
              _largeCard(
                context: context,
                color: Colors.red,
                icon: Icons.add_box,
                label: 'Create Product',
                onTap: onCreate,
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ],
    );
  }
}
