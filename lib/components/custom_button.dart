import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color color;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;

  const CustomButton({super.key,
    required this.title,
    required this.onPressed,
    this.color = Colors.blue, // Default color if none is provided
    this.width = 200, // Default button width
    this.height = 50,  // Default button height
    this.padding = const EdgeInsets.symmetric(vertical: 10), // Default padding
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: width,   // Setting button width
        height: height, // Setting button height
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,   // Button background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0), // Rounded corners
            ),
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,   // Button text color
              fontSize: 16,          // Font size
              fontWeight: FontWeight.bold, // Bold text
            ),
          ),
        ),
      ),
    );
  }
}
