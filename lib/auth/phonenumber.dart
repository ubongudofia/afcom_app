import 'package:flutter/material.dart';

class PhoneNumberScreen extends StatelessWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieve the user details passed from the previous screen
    final user =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    // Check if user data is available, else display an error message or fallback
    if (user == null || user['phone'] == null) {
      return const Scaffold(
        body: Center(
          child: Text('Error: User data not found.'),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEDF2FA), // Updated background color
        appBar: AppBar(
          backgroundColor: const Color(0xFFEDF2FA), // Matches button color
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                color: Colors.white), // White arrow
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous page
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 150, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rounded white background for text and input field
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Phone Number',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Read-only phone number field with visible outline
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: TextField(
                        controller: TextEditingController(text: user['phone']),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Phone Number',
                        ),
                        readOnly:
                            true, // Ensures the phone number is not editable
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Floating Action Button at the bottom-right
        floatingActionButton: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: () {
              // Simulate sending OTP and navigate to the OTP screen
              Navigator.pushNamed(context, '/otp', arguments: user);
            },
            backgroundColor: const Color.fromARGB(255, 14, 95, 133),
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white, // White arrow icon
            ),
          ),
        ),
      ),
    );
  }
}
