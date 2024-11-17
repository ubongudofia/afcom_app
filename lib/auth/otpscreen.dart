import 'package:flutter/material.dart';
import 'dart:async'; // For the countdown timer

class PhoneOtpScreen extends StatefulWidget {
  const PhoneOtpScreen({Key? key}) : super(key: key);

  @override
  _PhoneOtpScreenState createState() => _PhoneOtpScreenState();
}

class _PhoneOtpScreenState extends State<PhoneOtpScreen> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  Timer? _timer;
  int _secondsRemaining = 30; // Set the countdown timer for 30 seconds
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer(); // Start the timer when the screen is loaded
  }

  void _startTimer() {
    _secondsRemaining = 30;
    _canResend = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _canResend = true; // Enable the resend button when the timer ends
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Dispose the timer when the screen is destroyed
    _focusNodes.forEach((node) => node.dispose()); // Dispose focus nodes
    super.dispose();
  }

  void _submitOtp() {
    final otp = _otpControllers.map((controller) => controller.text).join();

    if (otp.length == 6) {
      // Simulate OTP validation
      final user =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;

      // Navigate to Email OTP Screen with user info
      Navigator.pushReplacementNamed(context, '/email', arguments: user);
    } else {
      _showErrorDialog();
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Invalid OTP'),
          content: const Text('Please enter the complete 6-digit OTP.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _resendOtp() {
    setState(() {
      _startTimer(); // Restart the timer
    });

    // Trigger OTP resend logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('OTP has been resent to your phone number!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEDF2FA), // Updated background color
        appBar: AppBar(
          backgroundColor: const Color(0xFFEDF2FA),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                color: Colors.white), // White back arrow
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
              // OTP instruction text
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
                child: Text(
                  'Enter the OTP sent to ${user['phone_number']}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // OTP input fields with shadow
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return Container(
                    width: 40,
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
                    child: TextField(
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index],
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        counterText: '', // Removes counter
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 5) {
                          _focusNodes[index + 1].requestFocus();
                        } else if (value.isEmpty && index > 0) {
                          _focusNodes[index - 1].requestFocus();
                        }
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),

              // Countdown timer or Resend OTP button
              if (!_canResend)
                Text(
                  'Resend OTP in $_secondsRemaining seconds',
                  style: const TextStyle(fontSize: 16),
                ),
              if (_canResend)
                TextButton(
                  onPressed: _resendOtp,
                  child: const Text('Resend OTP'),
                ),

              const SizedBox(height: 375),

              // Circular submit button with blue background and white arrow
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: _submitOtp,
                  backgroundColor: const Color.fromARGB(255, 14, 95, 133),
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
