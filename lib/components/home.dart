import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'custom_button.dart'; // Import custom button if you're using it

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late VideoPlayerController controller;
  String username = 'User';
  bool isLoggedIn = false; // Track login state
  String? token; // Simulate the token for checking login status

  @override
  void initState() {
    super.initState();
    _loadUsername();

    // Initialize VideoPlayerController with asset
    controller = VideoPlayerController.asset(
      'assets/home_display.gif',
    )..initialize().then((_) {
        setState(() {
          controller.setLooping(true); // Set looping after initialization
          controller.play(); // Start playing after initialization
        });
      });
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'User';
    });
  }

  void _openDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // Check login status
      _checkLoginStatus();
    }
  }

  void _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // Get current route name
    String currentRoute = ModalRoute.of(context)?.settings.name ?? '';

    if (!isLoggedIn && currentRoute != '/login') {
      // Redirect to login if not logged in and not already on the login page
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome $username'),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _openDrawer(context), // Open drawer on button tap
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text("Login"),
              onTap: () {
                Navigator.pushNamed(context, '/login'); // Navigate to login
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', false);
                await prefs.remove('username'); // Clear stored username
                if (!context.mounted) return;
                Navigator.pushReplacementNamed(context, '/login');
                // Navigate to login
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: 500,
                height: 250,
                child: Image.asset(
                  'assets/home_display.gif', // Replace with the actual GIF path
                  fit: BoxFit.cover, // Adjust the fit if necessary
                ),
              ),
            ),
            const SizedBox(height: 20.0),

            // Video Player
            controller.value.isInitialized
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    height: 200,
                    child: AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: VideoPlayer(controller),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue[50],
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.hotel, size: 40, color: Colors.blue),
                          SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Chosen Hotel: The Grand Palace',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Room: Deluxe Suite',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
            const SizedBox(height: 5.0),

            // Buttons Section (Explore Amenities and Manage Booking)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      title: 'Explore Facilities',
                      color: Colors.blue[600]!, // Deep blue color
                      onPressed: () {
                        Navigator.pushNamed(context, '/facilities');
                      },
                    ),
                  ),
                  const SizedBox(height: 5), // Spacing between buttons
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      title: 'Manage Booking',
                      color: Colors.blue[600]!, // Deep blue color
                      onPressed: () {
                        Navigator.pushNamed(context, '/manage_booking');
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10.0),

            // Functionalities Card Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: [
                      _buildFunctionalityCard(
                        title: 'Events & Attractions',
                        icon: Icons.event,
                        onTap: () {
                          Navigator.pushNamed(context, '/events');
                        },
                      ),
                      _buildFunctionalityCard(
                        title: 'Personalized Planner',
                        icon: Icons.map,
                        onTap: () {
                          Navigator.pushNamed(context, '/personalized_planner');
                        },
                      ),
                      _buildFunctionalityCard(
                        title: 'Exclusive Offers',
                        icon: Icons.local_offer,
                        onTap: () {
                          Navigator.pushNamed(context, '/offers');
                        },
                      ),
                      _buildFunctionalityCard(
                        title: 'User Reviews',
                        icon: Icons.rate_review,
                        onTap: () {
                          Navigator.pushNamed(context, '/reviews');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),

            // Need Help Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        title: 'Need help? Contact us now.',
                        color: Colors.blue[600]!,
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFunctionalityCard(
      {required String title,
      required IconData icon,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.blue),
              const SizedBox(height: 10),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
