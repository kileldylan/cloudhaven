// routes/authRoutes.js
const express = require('express');
const authController = require('../controllers/authController');
const router = express.Router();
const { body } = require('express-validator');
const restaurantBookingController = require('../controllers/restaurantBookingController');

// Define route for booking a table
router.post(
  '/restaurant_booking',
  [
    body('name').notEmpty().withMessage('Name is required'),
    body('email').isEmail().withMessage('Please enter a valid email'),
    body('phone').notEmpty().withMessage('Phone is required'),
    body('date').notEmpty().withMessage('Date is required'),
    body('time').notEmpty().withMessage('Time is required'),
    body('guests').isNumeric().withMessage('Guests should be a number'),
  ],
  restaurantBookingController.bookRestaurantTable
);

router.post('/login', authController.login);
router.post('/register', authController.register);


module.exports = router;
