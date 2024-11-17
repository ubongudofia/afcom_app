import 'package:flutter/material.dart';

class EmailScreen extends StatelessWidget {
  const EmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFFEDF2FA), // Consistent AppBar color
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), // Backward arrow icon
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous page
            },
          ),
          elevation: 0, // Flat AppBar to match the design
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 150, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Email Label
              const Text(
                'Email',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Input field with read-only email and consistent shadow
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // Shadow position
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Enter your email',
                  ),
                  controller: TextEditingController(text: user['email']),
                  readOnly: true, // Email is not editable
                ),
              ),
              const SizedBox(height: 400),

              // Circular submit button with blue background and white arrow
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () {
                    // Simulate sending email OTP and navigate to Email OTP screen
                    Navigator.pushNamed(context, '/email_otp', arguments: user);
                  },
                  backgroundColor: const Color.fromARGB(
                      255, 14, 95, 133), // Consistent button color
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white, // White arrow icon
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
