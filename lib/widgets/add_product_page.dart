import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _thumbnailController = TextEditingController();

  // Use a dropdown for category to demonstrate correct typed input
  final List<String> _categories = [
    'Shoes',
    'Balls',
    'Clothing',
    'Accessories',
    'Other',
  ];
  String? _selectedCategory;

  bool _isFeatured = false;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _thumbnailController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null) return 'Name is required';
    final s = value.trim();
    if (s.isEmpty) return 'Name is required';
    if (s.length < 3) return 'Name must be at least 3 characters';
    if (s.length > 100) return 'Name must be at most 100 characters';
    return null;
  }

  String? _validatePrice(String? value) {
    if (value == null) return 'Price is required';
    final s = value.trim();
    if (s.isEmpty) return 'Price is required';
    final parsed = double.tryParse(s.replaceAll(',', '.'));
    if (parsed == null) return 'Price must be a valid number';
    if (parsed.isNaN) return 'Price must be a valid number';
    if (parsed < 0) return 'Price cannot be negative';
    if (parsed == 0) return 'Price must be greater than zero';
    if (parsed > 10000000) return 'Price seems unreasonably large';
    return null;
  }

  String? _validateDescription(String? value) {
    if (value == null) return 'Description is required';
    final s = value.trim();
    if (s.isEmpty) return 'Description is required';
    if (s.length < 10) return 'Description must be at least 10 characters';
    if (s.length > 1000) return 'Description must be at most 1000 characters';
    return null;
  }

  String? _validateThumbnail(String? value) {
    if (value == null) return 'Thumbnail URL is required';
    final s = value.trim();
    if (s.isEmpty) return 'Thumbnail URL is required';

    // Basic URL validation. Accepts http and https.
    final uri = Uri.tryParse(s);
    if (uri == null ||
        !(uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https'))) {
      return 'Thumbnail must be a valid http/https URL';
    }

    // Optional: check for common image extensions
    final lower = s.toLowerCase();
    if (!(lower.endsWith('.png') ||
        lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.webp') ||
        lower.endsWith('.gif'))) {
      // Not a hard failure, but warn user. We'll still accept it.
      // To enforce, return an error instead of null.
      // return 'Thumbnail should point to an image (png/jpg/jpeg/webp/gif)';
    }

    return null;
  }

  String? _validateCategory(String? value) {
    if (value == null || value.trim().isEmpty) return 'Category is required';
    if (!_categories.contains(value)) return 'Please select a valid category';
    return null;
  }

  void _onSave() {
    // Trigger validation
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix errors before saving')),
      );
      return;
    }

    final name = _nameController.text.trim();
    final price = double.parse(
      _priceController.text.trim().replaceAll(',', '.'),
    );
    final description = _descriptionController.text.trim();
    final thumbnail = _thumbnailController.text.trim();
    final category = _selectedCategory!.trim();
    final isFeatured = _isFeatured;

    final product = {
      'name': name,
      'price': price,
      'description': description,
      'thumbnail': thumbnail,
      'category': category,
      'isFeatured': isFeatured,
    };

    // Print to console as requested
    print('AddProductPage: saving product: $product');

    // Show pop-up with product data
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Product Data'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: $name'),
                Text('Price: $price'),
                Text('Description: $description'),
                Text('Thumbnail: $thumbnail'),
                Text('Category: $category'),
                Text('Featured: ${isFeatured ? "Yes" : "No"}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product data printed to console')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter product name',
                ),
                textInputAction: TextInputAction.next,
                validator: _validateName,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  hintText: 'Enter price (e.g. 49.99)',
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                textInputAction: TextInputAction.next,
                validator: _validatePrice,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter a description for the product',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 3,
                validator: _validateDescription,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _thumbnailController,
                decoration: const InputDecoration(
                  labelText: 'Thumbnail URL',
                  hintText: 'https://example.com/image.png',
                ),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.next,
                validator: _validateThumbnail,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: _categories
                    .map(
                      (c) => DropdownMenuItem<String>(value: c, child: Text(c)),
                    )
                    .toList(),
                hint: const Text('Select category'),
                onChanged: (v) => setState(() => _selectedCategory = v),
                validator: _validateCategory,
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Featured'),
                  Switch(
                    value: _isFeatured,
                    onChanged: (v) => setState(() => _isFeatured = v),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[800],
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 16),
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
