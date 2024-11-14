// controllers/restaurantBookingController.js
const db = require('../config/db'); // Import your database connection
const { validationResult } = require('express-validator');

// POST request to handle restaurant bookings
exports.bookRestaurantTable = async (req, res) => {
  // Extract booking data from the request body
  const {
    name,
    email,
    phone,
    date,
    time,
    guests,
    requests,
    seating
  } = req.body;

  // Validate input
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  try {
    // Insert booking data into the database
    const query = `
      INSERT INTO restaurant_bookings (name, email, phone, date, time, guests, requests, seating)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    `;
    const values = [name, email, phone, date, time, guests, requests, seating];

    db.query(query, values, (error, results) => {
      if (error) {
        console.error('Database insert error:', error);
        return res.status(500).json({ message: 'Booking failed due to database error.' });
      }

      res.status(201).json({ message: 'Booking successful!', bookingId: results.insertId });
    });
  } catch (error) {
    console.error('Booking error:', error);
    res.status(500).json({ message: 'An unexpected error occurred. Please try again later.' });
  }S
};
