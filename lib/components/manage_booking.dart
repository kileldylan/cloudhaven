import 'package:flutter/material.dart';

class ManageBookingScreen extends StatelessWidget {
  ManageBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Booking'),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(booking['hotel']),
              subtitle: Text('Check-in: ${booking['checkIn']}\nCheck-out: ${booking['checkOut']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle Cancel Booking
                    },
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Modify Booking
                    },
                    child: const Text('Modify'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  final List<Map<String, dynamic>> bookings = [
    {
      "hotel": "Ocean View Hotel",
      "checkIn": "October 25, 2024",
      "checkOut": "October 30, 2024",
    },
    {
      "hotel": "The Grand Palace",
      "checkIn": "November 1, 2024",
      "checkOut": "November 5, 2024",
    },
    // Add more bookings
  ];
}
