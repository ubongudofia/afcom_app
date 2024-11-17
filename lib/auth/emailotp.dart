import 'package:flutter/material.dart';
import 'dart:async'; // For the countdown timer

class EmailOtpScreen extends StatefulWidget {
  const EmailOtpScreen({Key? key}) : super(key: key);

  @override
  _EmailOtpScreenState createState() => _EmailOtpScreenState();
}

class _EmailOtpScreenState extends State<EmailOtpScreen> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(6, (_) => FocusNode()); // Create focus nodes
  Timer? _timer;
  int _secondsRemaining = 30; // Set the countdown timer for 30 seconds
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer(); // Start the timer when the screen is loaded

    // Add listener to each OTP input field
    for (int i = 0; i < _otpControllers.length; i++) {
      _otpControllers[i].addListener(() {
        _handleOtpInput(i);
      });
    }
  }

  void _startTimer() {
    _secondsRemaining = 30;
    _canResend = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _canResend = true; // Enable the resend button when timer ends
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Dispose the timer when the screen is destroyed
    for (var focusNode in _focusNodes) {
      focusNode.dispose(); // Dispose of focus nodes
    }
    super.dispose();
  }

  void _handleOtpInput(int index) {
    if (_otpControllers[index].text.length == 1) {
      // Move focus to the next TextField if a digit is entered
      if (index < _focusNodes.length - 1) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      }
    } else if (_otpControllers[index].text.isEmpty && index > 0) {
      // Move focus back to the previous TextField if the current is cleared
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  void _submitOtp() {
    final otp = _otpControllers.map((controller) => controller.text).join();

    if (otp.length == 6) {
      // Simulate OTP validation
      final user =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;

      // Navigate to Password Setup Screen with user info
      Navigator.pushReplacementNamed(context, '/password_setup',
          arguments: user);
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

    // Here you would normally trigger the OTP resend logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('OTP has been resent to your email!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFFEDF2FA),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), // Backward arrow icon
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous page
            },
          ),
          elevation: 0, // To match the flat AppBar design
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 150, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display email information
              Text(
                'Enter the OTP sent to ${user['email']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return Container(
                    width: 40,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12), // Consistent radius
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index], // Set focus node
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),

              // Resend OTP timer and button
              if (!_canResend)
                Text('Resend OTP in $_secondsRemaining seconds'),
              if (_canResend)
                TextButton(
                  onPressed: _resendOtp,
                  child: const Text('Resend OTP'),
                ),
              const SizedBox(height: 375),

              // Floating Action Button
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: _submitOtp,
                  backgroundColor: const Color.fromARGB(255, 14, 95, 133), // Consistent button color
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
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
