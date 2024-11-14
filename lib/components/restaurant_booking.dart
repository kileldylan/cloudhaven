import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RestaurantBookingScreen extends StatefulWidget {
  const RestaurantBookingScreen({super.key});

  @override
  _RestaurantBookingScreenState createState() =>
      _RestaurantBookingScreenState();
}

class _RestaurantBookingScreenState extends State<RestaurantBookingScreen> {
  // Controllers for input fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _guestsController = TextEditingController();
  final TextEditingController _requestsController = TextEditingController();
  final TextEditingController _seatingController = TextEditingController();

  Future<void> bookTable() async {
    // Replace with your backend API URL
    const String apiUrl =
        'http://198.168.8.128:3000/api/auth/restaurant_booking';

    // Send the booking details to the API
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'date': _dateController.text,
        'time': _timeController.text,
        'guests': _guestsController.text,
        'requests': _requestsController.text,
        'seating': _seatingController.text,
      }),
    );

    // Check if booking was successful
    if (response.statusCode == 201) {
      // Booking successful
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking successful!')),
      );

      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context, '/manage_booking');
      });
    } else {
      // Error occurred during booking
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to book. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book a Table')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name input
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  icon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 10),

              // Email input
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  icon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),

              // Phone input
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  icon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),

              // Date input
              TextField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Date (YYYY-MM-DD)',
                  icon: Icon(Icons.calendar_today),
                ),
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 10),

              // Time input
              TextField(
                controller: _timeController,
                decoration: const InputDecoration(
                  labelText: 'Time (HH:MM)',
                  icon: Icon(Icons.access_time),
                ),
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 10),

              // Guests input
              TextField(
                controller: _guestsController,
                decoration: const InputDecoration(
                  labelText: 'Number of Guests',
                  icon: Icon(Icons.group),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),

              // Special Requests input
              TextField(
                controller: _requestsController,
                decoration: const InputDecoration(
                  labelText: 'Special Requests (optional)',
                  icon: Icon(Icons.note),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 2,
              ),
              const SizedBox(height: 10),

              // Seating Preference input
              TextField(
                controller: _seatingController,
                decoration: const InputDecoration(
                  labelText: 'Seating Preference (optional)',
                  icon: Icon(Icons.chair),
                ),
              ),
              const SizedBox(height: 20),

              // Book Now button
              Center(
                child: ElevatedButton(
                  onPressed: bookTable,
                  child: const Text('Book Now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
