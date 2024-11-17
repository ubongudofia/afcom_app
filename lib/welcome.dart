import 'package:flutter/material.dart';
import 'auth/mockdb.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int selectedOption = -1; // Track the selected option

  // Function to display the modal popup with options
  void _showOptionModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Center(
            child: Text('Choose your Service',
              style: TextStyle(
                color: Color(0xFF2196F3),
              ),),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOption(0, 'Nigerian Army', 'assets/images/army_logo-1.png'),
              _buildOption(1, 'Nigerian Navy', 'assets/images/navy_logo-1.png'),
              _buildOption(2, 'Nigerian Airforce', 'assets/images/air_force.png'),
            ],
          ),
          // actions: [
          //   TextButton(
          //     onPressed: () => Navigator.of(context).pop(),
          //     child: Text('Close'),
          //   ),
          // ],
        );
      },
    );
  }

  // Helper function to build each option in the modal
  Widget _buildOption(int index, String name, String imagePath) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(imagePath),
      ),
      title: Text(name),
      trailing: Radio(
        value: index,
        groupValue: selectedOption,
        onChanged: (int? value) {
          setState(() {
            selectedOption = value!;
          });
        },
      ),
      onTap: () {
        setState(() {
          selectedOption = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/nig_defence_logo.jpg', // Replace with your background image path
              fit: BoxFit.cover,
            ),
          ),
          // Main content
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Image.asset(
                      'assets/images/dhq_logo.png',
                      width: 250,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    child: Text(
                      'AFCOM',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Center(
                    child: SizedBox(
                      width: 350,
                      child: Text(
                        'Armed Forces of Nigeria Messaging App',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                  Center(
                    child: ElevatedButton(
                      onPressed: _showOptionModal, // Opens the modal popup
                      style: ButtonStyle(
                        foregroundColor:
                        WidgetStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                        WidgetStateProperty.all<Color>(const Color(0xFFFFFFFF)),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 22,
                            color: Color(0xFF2196F3),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        final user = MockDatabase.findUserByServiceNumber('123456');
                        if (user != null) {
                          final userName = user['name'] ?? 'Unknown';
                          Navigator.pushNamed(
                            context,
                            '/login_page',
                            arguments: {'name': userName},
                          );
                        }
                      },
                      child: const Text(
                        'Already a user? Sign in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
