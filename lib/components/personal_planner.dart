import 'package:flutter/material.dart';

class PersonalizedTripPlannerScreen extends StatefulWidget {
  const PersonalizedTripPlannerScreen({super.key});

  @override
  _PersonalizedTripPlannerScreenState createState() => _PersonalizedTripPlannerScreenState();
}

class _PersonalizedTripPlannerScreenState extends State<PersonalizedTripPlannerScreen> {
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController activitiesController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();

  List<String> itinerary = [];

  void generateItinerary() {
    setState(() {
      itinerary.add('Day 1: Explore ${destinationController.text}');
      itinerary.add('Day 2: Visit local attractions');
      itinerary.add('Day 3: Enjoy activities based on ${activitiesController.text}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personalized Trip Planner'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: destinationController,
              decoration: const InputDecoration(labelText: 'Destination'),
            ),
            TextField(
              controller: durationController,
              decoration: const InputDecoration(labelText: 'Duration (days)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: activitiesController,
              decoration: const InputDecoration(labelText: 'Type of Activities'),
            ),
            TextField(
              controller: budgetController,
              decoration: const InputDecoration(labelText: 'Budget Range'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: generateItinerary,
              child: const Text('Generate Itinerary'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: itinerary.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(itinerary[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
