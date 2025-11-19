import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:elevenkick/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter your username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Confirm your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () async {
                      String username = _usernameController.text;
                      String password1 = _passwordController.text;
                      String password2 = _confirmPasswordController.text;

                      // Basic validation
                      if (username.isEmpty ||
                          password1.isEmpty ||
                          password2.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all fields'),
                          ),
                        );
                        return;
                      }

                      if (password1 != password2) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Passwords do not match'),
                          ),
                        );
                        return;
                      }

                      final request = Provider.of<CookieRequest>(
                        context,
                        listen: false,
                      );

                      try {
                        final cookies = request.cookies;
                        final response = await http
                            .post(
                              Uri.parse('http://localhost:8000/auth/register/'),
                              headers: {
                                'Content-Type': 'application/json',
                                'Cookie': cookies.entries
                                    .map((e) => '${e.key}=${e.value}')
                                    .join('; '),
                              },
                              body: jsonEncode({
                                'username': username,
                                'password1': password1,
                                'password2': password2,
                              }),
                            )
                            .timeout(
                              const Duration(seconds: 10),
                              onTimeout: () => http.Response(
                                '{"status":"error","message":"Request timeout"}',
                                408,
                              ),
                            );

                        debugPrint(
                          'Register response: ${response.statusCode} ${response.body}',
                        );

                        Map<String, dynamic> responseData = {};
                        if (response.statusCode == 200 ||
                            response.statusCode == 201) {
                          try {
                            responseData = jsonDecode(response.body);
                          } catch (e) {
                            responseData = {
                              'status': 'error',
                              'message': 'Invalid response format',
                            };
                          }
                        } else {
                          String errorDetail =
                              'Server error: ${response.statusCode}';
                          try {
                            final errorBody = jsonDecode(response.body);
                            if (errorBody is Map) {
                              errorDetail =
                                  errorBody['message'] ??
                                  errorBody['error']?.toString() ??
                                  response.body;
                            } else {
                              errorDetail = response.body;
                            }
                          } catch (e) {
                            errorDetail = response.body.isNotEmpty
                                ? response.body
                                : 'Server error: ${response.statusCode}';
                          }
                          debugPrint('Server error details: $errorDetail');
                          responseData = {
                            'status': 'error',
                            'message': errorDetail,
                          };
                        }

                        if (!context.mounted) return;

                        if (responseData['status'] == 'success' ||
                            responseData['status'] == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Successfully registered!'),
                            ),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        } else {
                          String errorMsg =
                              responseData['message']?.toString() ??
                              responseData['errors']?.toString() ??
                              'Failed to register!';
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Register Failed'),
                              content: Text(errorMsg),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          );
                        }
                      } catch (e) {
                        debugPrint('Error during registration: $e');
                        if (!context.mounted) return;
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Error'),
                            content: Text('Failed to register: $e'),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
