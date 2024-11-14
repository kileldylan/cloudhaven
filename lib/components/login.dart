import 'package:cloudhaven/components/registration.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import http package
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart'; // Import for JSON encoding/decoding

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String message = '';

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(
          // ignore: use_build_context_synchronously
          context,
          '/home'); // Navigate to home if logged in
    }
  }

  Future<void> login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    // Check if username or password fields are empty
    if (username.isEmpty || password.isEmpty) {
      setState(() {
        message = 'Please fill out both fields';
      });
      // Hide message after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          message = ''; // Clear the message
        });
      });
      return; // Stop further execution if inputs are empty
    }

    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.8.128:3000/api/auth/login'), // Replace with your API URL
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      // Check the status code and handle different responses
      if (response.statusCode == 200) {
        // Try to decode the response as JSON
        try {
          final data = jsonDecode(response.body);
          // Handle the JSON data as needed
          debugPrint('Login successful: $data');
        } catch (e) {
          // Handle JSON decoding errors
          debugPrint('Error decoding JSON: $e');
          debugPrint('Response body: ${response.body}');
          // Optionally, show a message to the user
        }
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        String token = responseData['token'];
        _saveUsername(
            username); // After parsing the token and storing login status

        // Save the token in shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', token);
        await prefs.setBool('isLoggedIn', true); // Store login status

        // Navigate to the next page or home page
        Navigator.pushReplacementNamed(
            context, '/home'); // Adjust the route as needed
      } else {
        // Handle non-200 responses (e.g., 404, 500)
        debugPrint(
            'Request failed with status: ${response.statusCode}. Response: ${response.body}');
        // Optionally, show an error message to the user
      }
    } catch (error) {
      // Handle network errors (like timeout, etc.)
      debugPrint('Network error: $error');
      // Optionally, show an error message to the user
    }
    // Hide error message after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        message = ''; // Clear the message
      });
    });
  }

  Future<void> _saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

// Call _saveUsername with the logged-in user's username during login.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/cloudhaven_logo.jpg', // Your logo asset path
              width: 1200,
              height: 300,
              fit: BoxFit.cover, // Make the image cover the entire screen
            ),
            Padding(
              padding: const EdgeInsets.all(16.0), // Padding for the whole form
              child: Column(
                children: [
                  TextField(
                    controller:
                        usernameController, // Use the defined controller
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0), // Space between fields
                  TextField(
                    controller:
                        passwordController, // Use the defined controller
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true, // For password fields
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: login, // Call the login function
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the registration page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()),
                      );
                    },
                    child: const Text(
                      "Don't have an account? Sign up",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(message,
                      style:
                          const TextStyle(color: Colors.red)), // Show messages
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
