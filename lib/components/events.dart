import 'package:flutter/material.dart';

class LocalAttractionsScreen extends StatelessWidget {
  LocalAttractionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events & Attractions'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Discover local attractions, events, and activities around your area.",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
            ),
            // Attractions List
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Attractions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: attractions.map((attraction) {
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    leading: Image.asset(attraction['image']),
                    title: Text(attraction['name']),
                    subtitle: Text('${attraction['location']} \nRating: ${attraction['rating']}'),
                    isThreeLine: true,
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Navigate to details page (not implemented here)
                      },
                      child: const Text('View Details'),
                    ),
                  ),
                );
              }).toList(),
            ),
            // Events List
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Upcoming Events',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: events.map((event) {
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    leading: Image.asset(event['image']),
                    title: Text(event['name']),
                    subtitle: Text('${event['date']} \nLocation: ${event['location']}'),
                    isThreeLine: true,
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Navigate to RSVP or details page (not implemented here)
                      },
                      child: const Text('RSVP'),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> attractions = [
    {
      "name": "Central Park",
      "location": "Downtown",
      "rating": 4.8,
      "image": "assets/cental_park.jpg",
    },
    {
      "name": "Museum of Art",
      "location": "Arts District",
      "rating": 4.6,
      "image": "assets/cloudhaven_logo.jpg",
    },
    // Add more attractions
  ];

  final List<Map<String, dynamic>> events = [
    {
      "name": "Food Festival",
      "date": "October 25, 2024",
      "location": "City Square",
      "image": "assets/cloudhaven_logo.jpg",
    },
    {
      "name": "Live Concert",
      "date": "November 1, 2024",
      "location": "Music Hall",
      "image": "assets/cloudhaven_logo.jpg",
    },
    // Add more events
  ];
}
