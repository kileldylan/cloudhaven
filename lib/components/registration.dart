import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String message = '';

  Future<void> register() async {
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      setState(() {
        message = 'Please fill out all fields';
      });
      return;
    }

    final response = await http.post(
      Uri.parse(
          'http://192.168.8.128:3000/api/auth/register'), // Use your backend URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      setState(() {
        message = 'User registered successfully! You can now log in.';
      });

      // Redirect back to login page after a brief delay
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(
            context, '/login'); // Redirect to login after 2 seconds
      });
    } else {
      final errorData = jsonDecode(response.body);
      setState(() {
        message = errorData['error'] ?? 'Registration failed';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/cloudhaven_logo.jpg', // Your logo asset path
              width: 1200,
              height: 300,
              fit: BoxFit.cover, // Make the image cover the entire screen
// Adjust the logo size
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller:
                        usernameController, // Use the username controller
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: emailController, // Use the email controller
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller:
                        passwordController, // Use the password controller
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true, // For password fields
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: register, //call the register function
                    child: const Text('Register'),
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
