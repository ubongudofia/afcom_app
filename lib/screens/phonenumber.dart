import 'package:flutter/material.dart';

import 'email.dart';

class PhoneNumberScreen extends StatefulWidget {
  final Map<String, String> user;

  const PhoneNumberScreen({Key? key, required this.user}) : super(key: key);

  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool otpSent = false;

  //Simulate sending OTP
  void sendOTP() {
    // Simulate OTP sent to the phone number
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('OTP sent to ${widget.user['phone_number']}')),
    );
    setState(() {
      otpSent = true;
    });
  }

  void submitOTP() {
    String enteredOTP = _otpController.text;

    if (enteredOTP == '123456') {
      // Simulate correct OTP
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmailScreen(user: widget.user),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Number Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display phone number
            TextField(
              controller:
                  TextEditingController(text: widget.user['phone_number']),
              decoration: const InputDecoration(labelText: 'Phone Number'),
              readOnly: true,
            ),
            const SizedBox(height: 20),
            // OTP Input
            if (otpSent)
              TextField(
                controller: _otpController,
                decoration: const InputDecoration(labelText: 'Enter OTP'),
              ),
            const SizedBox(height: 20),
            // Send OTP button or submit OTP button based on state
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: otpSent ? submitOTP : sendOTP,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16),
                ),
                child: const Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
