import 'package:flutter/material.dart';
import 'package:elevenkick/screens/menu.dart';
import 'package:elevenkick/screens/add_product_page.dart';
import 'package:elevenkick/screens/register.dart';
import 'package:elevenkick/screens/login.dart';
import 'package:elevenkick/screens/products_list.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'Eleven Kick',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            primary: Colors.blue,
            secondary: const Color(0xFFFFF9C4), // soft yellow
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
          splashColor: const Color.fromRGBO(33, 150, 243, 0.2),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.blue,
            selectionColor: Color(0xFFFFF9C4),
            selectionHandleColor: Colors.blue,
          ),
        ),
        home: const MyHomePage(title: 'ElevenKick'),
      ),
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
  // Removed unused _counter field

  void _goToAddProductPage() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const AddProductPage()));
  }

  @override
  Widget build(BuildContext context) {
    final request = Provider.of<CookieRequest>(context);
    final loggedIn = request.loggedIn;
    final username = request.jsonData['username'] ?? '';
    return Scaffold(
      appBar: AppBar(
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
              child: loggedIn
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Menu',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Welcome, $username',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                  : const Text(
                      'Menu',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Halaman Utama'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const MyHomePage(title: 'ElevenKick'),
                  ),
                  (route) => false,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Daftar Produk'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ProductsListPage()),
                );
              },
            ),
            if (loggedIn) ...[
              ListTile(
                leading: const Icon(Icons.add_box),
                title: const Text('Tambah Produk'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const AddProductPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () async {
                  await request.logout("http://localhost:8000/auth/logout/");
                  if (context.mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => const MyHomePage(title: 'ElevenKick'),
                      ),
                      (route) => false,
                    );
                  }
                },
              ),
            ] else ...[
              ListTile(
                leading: const Icon(Icons.login),
                title: const Text('Login'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => const LoginPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_add),
                title: const Text('Register / Daftar Akun'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const RegisterPage()),
                  );
                },
              ),
            ],
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (loggedIn)
                Text(
                  'Welcome, $username!',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (!loggedIn)
                const Text('Silakan login untuk mengakses fitur lengkap.'),
              const SizedBox(height: 24),
              ProductActionMenu(onCreate: _goToAddProductPage),
            ],
          ),
        ),
      ),
      floatingActionButton: loggedIn
          ? FloatingActionButton(
              onPressed: _goToAddProductPage,
              tooltip: 'Tambah Produk',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
