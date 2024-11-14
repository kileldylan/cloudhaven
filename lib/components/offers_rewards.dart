import 'package:flutter/material.dart';

class ExclusiveOffersScreen extends StatelessWidget {
  final List<Map<String, String>> offers = [
    {
      "title": "20% off on Spa Services",
      "description": "Enjoy a relaxing spa day at a discounted price.",
      "validity": "Valid until 30th Nov 2024",
      "terms": "Terms and conditions apply."
    },
    {
      "title": "Free Breakfast with Your Stay",
      "description": "Get complimentary breakfast with every night booked.",
      "validity": "Valid until 15th Dec 2024",
      "terms": "Applicable only on direct bookings."
    },
  ];

  ExclusiveOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exclusive Offers and Rewards'),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView.builder(
        itemCount: offers.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offers[index]['title']!,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(offers[index]['description']!),
                  const SizedBox(height: 8),
                  Text(offers[index]['validity']!),
                  const SizedBox(height: 8),
                  Text(offers[index]['terms']!, style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Handle claiming the offer
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Claim Offer'),
                          content: const Text('Are you sure you want to claim this offer?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                // Claim the offer logic
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text('Offer claimed successfully!'),
                                ));
                              },
                              child: const Text('Yes'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('No'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('Claim Offer'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
