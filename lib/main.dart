import 'package:flutter/material.dart';
import 'package:elevenkick/widgets/menu.dart';
import 'package:elevenkick/widgets/add_product_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ElevenKick',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue,
          secondary: const Color(0xFFFFF9C4), // soft yellow
          background: Colors.white,
          surface: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.blue,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 2,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 16),
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.blue),
        highlightColor: const Color(0xFFFFF9C4), // soft yellow
        splashColor: Colors.blue.withOpacity(0.2),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.blue,
          selectionColor: Color(0xFFFFF9C4),
          selectionHandleColor: Colors.blue,
        ),
      ),
      home: const MyHomePage(title: 'ElevenKick'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _goToAddProductPage() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const AddProductPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Judul aplikasi "ElevenKick" dengan teks putih dan tebal.
        title: const Text(
          'ElevenKick',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Halaman Utama'),
              onTap: () {
                Navigator.of(context).pop(); // Close drawer
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const MyHomePage(title: 'ElevenKick'),
                  ),
                  (route) => false,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_box),
              title: const Text('Tambah Produk'),
              onTap: () {
                Navigator.of(context).pop(); // Close drawer
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AddProductPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('You have pushed the button this many times:'),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 24),
              ProductActionMenu(onCreate: _goToAddProductPage),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToAddProductPage,
        tooltip: 'Tambah Produk',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
