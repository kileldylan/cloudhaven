import 'package:cloudhaven/components/booking_page.dart';
import 'package:cloudhaven/components/explore_facilities.dart';
import 'package:cloudhaven/components/events.dart';
import 'package:cloudhaven/components/manage_booking.dart';
import 'package:cloudhaven/components/offers_rewards.dart';
import 'package:cloudhaven/components/personal_planner.dart';
import 'package:cloudhaven/components/registration.dart';
import 'package:cloudhaven/components/restaurant_booking.dart';
import 'package:cloudhaven/components/reviews.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import 'components/home.dart';
import 'components/login.dart';
import 'components/splash_screen.dart';

void main() {
  runApp(const CloudHavenApp());
  Wakelock.enable(); // Keeps the app active when the screen goes off
}

class CloudHavenApp extends StatelessWidget {
  const CloudHavenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CloudHaven',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/booking': (context) => const BookingPage(),
        '/manage_booking': (context) => ManageBookingScreen(),
        '/facilities': (context) => const ExploreAmenitiesPage(),
        '/events': (context) => LocalAttractionsScreen(),
        '/offers': (context) => ExclusiveOffersScreen(),
        '/personalized_planner': (context) =>
            const PersonalizedTripPlannerScreen(),
        '/restaurant_booking': (context) => const RestaurantBookingScreen(),
        '/reviews': (context) => const UserReviewsScreen(),
      },
    );
  }
}
