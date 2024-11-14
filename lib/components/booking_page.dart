import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String selectedRoomType = 'Deluxe Suite'; // Default room type
  DateTime? selectedDate;
  int numberOfGuests = 1;
  bool isPayingWithCard = true; // Default payment option

  // Dummy price map
  Map<String, double> roomPrices = {
    'Deluxe Suite': 150.0,
    'Executive Suite': 200.0,
    'Family Suite': 250.0,
    'Presidential Suite': 350.0,
  };

  // Function to select a room
  void _selectRoom(String roomType) {
    setState(() {
      selectedRoomType = roomType;
    });
  }

  // Function to pick booking date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Guest number picker
  void _updateGuests(int count) {
    setState(() {
      numberOfGuests = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Your Stay'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Room selection section
            const Text(
              'Select Room Type',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildRoomSelection(),

            const SizedBox(height: 20),

            // Date Picker
            const Text(
              'Select Booking Date',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildDatePicker(context),

            const SizedBox(height: 20),

            // Number of guests
            const Text(
              'Number of Guests',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildGuestSelector(),

            const SizedBox(height: 20),

            // Payment Option Section
            const Text(
              'Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildPaymentOptions(),

            const SizedBox(height: 20),

            // Book Now Button
            Center(
              child: ElevatedButton(
                onPressed: _bookNow,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text('Confirm Booking'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Room selection widget
  Widget _buildRoomSelection() {
    return Column(
      children: roomPrices.keys.map((roomType) {
        return ListTile(
          title: Text(roomType),
          subtitle: Text('Price: \$${roomPrices[roomType]} per night'),
          leading: Radio<String>(
            value: roomType,
            groupValue: selectedRoomType,
            onChanged: (String? value) {
              if (value != null) _selectRoom(value);
            },
          ),
        );
      }).toList(),
    );
  }

  // Date picker widget
  Widget _buildDatePicker(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () => _selectDate(context),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
          child: const Text('Select Date'),
        ),
        const SizedBox(width: 10),
        if (selectedDate != null)
          Text(
            'Selected: ${selectedDate!.toLocal()}'.split(' ')[0],
            style: const TextStyle(fontSize: 16),
          ),
      ],
    );
  }

  // Guest selector widget
  Widget _buildGuestSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Number of Guests:', style: TextStyle(fontSize: 16)),
        IconButton(
          onPressed: () {
            if (numberOfGuests > 1) _updateGuests(numberOfGuests - 1);
          },
          icon: const Icon(Icons.remove_circle_outline),
        ),
        Text('$numberOfGuests'),
        IconButton(
          onPressed: () => _updateGuests(numberOfGuests + 1),
          icon: const Icon(Icons.add_circle_outline),
        ),
      ],
    );
  }

  // Payment options widget
  Widget _buildPaymentOptions() {
    return Column(
      children: [
        ListTile(
          title: const Text('Credit/Debit Card'),
          leading: Radio<bool>(
            value: true,
            groupValue: isPayingWithCard,
            onChanged: (bool? value) {
              setState(() {
                isPayingWithCard = true;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('PayPal'),
          leading: Radio<bool>(
            value: false,
            groupValue: isPayingWithCard,
            onChanged: (bool? value) {
              setState(() {
                isPayingWithCard = false;
              });
            },
          ),
        ),
      ],
    );
  }

  // Dummy function for booking process
  void _bookNow() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Booking Confirmation'),
          content: Text(
              'You have booked a $selectedRoomType for $numberOfGuests guests on ${selectedDate != null ? selectedDate.toString().split(' ')[0] : "selected date"}.\n\nTotal cost: \$${(roomPrices[selectedRoomType]! * numberOfGuests).toStringAsFixed(2)}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
