import 'package:flutter/material.dart';

class ExploreAmenitiesPage extends StatefulWidget {
  const ExploreAmenitiesPage({super.key});

  @override
  _ExploreAmenitiesPageState createState() => _ExploreAmenitiesPageState();
}

class _ExploreAmenitiesPageState extends State<ExploreAmenitiesPage> {
  final List<String> categories = [
    "Restaurants",
    "BnBs",
    "Resorts",
    "Luxury Hotels"
  ];
  String selectedCategory = "Restaurants";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore Facilities"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search Facilities",
                prefixIcon: const Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          // Categories Selector
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = categories[index];
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: selectedCategory == categories[index]
                          ? Colors.blueGrey
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        categories[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // Display selected category with filtering and sorting options
          Expanded(
            child: ListView(
              children: [
                _buildAmenitiesList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenitiesList() {
    // For now, static mock data based on selected category
    List<Map<String, dynamic>> amenities = [
      {
        "name": "The Gourmet Bistro",
        "location": "City Center",
        "rating": 4.5,
        "image": "assets/ch_restaurant_gif.gif",
        "availability": true,
        "category": "Restaurants"
      },
      {
        "name": "Ocean View Hotel",
        "location": "Vipingo",
        "rating": 4.5,
        "image": "assets/ch_restaurant_gif.gif",
        "availability": true,
        "category": "Restaurants"
      },
      {
        "name": "Sunshine BnB",
        "location": "Beachfront",
        "rating": 4.7,
        "image": "assets/ch_bnb_ezgif.gif",
        "availability": false,
        "category": "BnBs"
      },
      // Add more amenities based on categories...
    ];

    // Filtering based on selected category
    List<Map<String, dynamic>> filteredAmenities = amenities
        .where((item) => item['category'] == selectedCategory)
        .toList();

    return Column(
      children: filteredAmenities.map((amenity) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              Image.asset(amenity['image'], fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      amenity['name'],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          amenity['location'],
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              index < amenity['rating']
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    amenity['availability']
                        ? ElevatedButton(
                            onPressed: () {
                              // Navigate to booking page
                              Navigator.pushNamed(
                                  context, '/restaurant_booking',
                                  arguments: amenity);
                            },
                            child: const Text("Book Now"),
                          )
                        : const Text(
                            "Not Available",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
