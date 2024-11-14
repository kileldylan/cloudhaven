import 'package:flutter/material.dart';

class UserReviewsScreen extends StatefulWidget {
  const UserReviewsScreen({super.key});

  @override
  _UserReviewsScreenState createState() => _UserReviewsScreenState();
}

class _UserReviewsScreenState extends State<UserReviewsScreen> {
  final List<Map<String, dynamic>> reviews = [];
  final TextEditingController reviewController = TextEditingController();
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Reviews and Ratings'),
        backgroundColor: Colors.blueGrey,

      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(reviews[index]['name']),
                        const SizedBox(height: 8),
                        Row(
                          children: List.generate(5, (starIndex) {
                            return Icon(
                              starIndex < reviews[index]['rating'] ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                            );
                          }),
                        ),
                        const SizedBox(height: 8),
                        Text(reviews[index]['review']),
                        const SizedBox(height: 8),
                        Text(reviews[index]['date']),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: reviewController,
                    decoration: const InputDecoration(
                      labelText: 'Write a review...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    setState(() {
                      reviews.add({
                        'name': 'User', // Replace with actual user name
                        'rating': rating.toInt(),
                        'review': reviewController.text,
                        'date': DateTime.now().toString().split(' ')[0],
                      });
                      reviewController.clear();
                    });
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 1; i <= 5; i++)
                IconButton(
                  icon: Icon(
                    i <= rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    setState(() {
                      rating = i.toDouble();
                    });
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
