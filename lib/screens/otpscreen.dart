import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  final String maskedValue; // The masked phone number or email to display
  final Function(String) onSubmitOtp; // Callback to handle OTP submission

  const OtpScreen({Key? key, required this.maskedValue, required this.onSubmitOtp}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());

  // Collect OTP from individual fields and submit
  void submitOtp() {
    String otp = otpControllers.map((controller) => controller.text).join();
    widget.onSubmitOtp(otp); // Pass OTP to the submit handler
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter OTP')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the instruction message
            Text(
              'Enter the OTP sent to ${widget.maskedValue}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // OTP input fields in white, rounded rectangular boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return Container(
                  width: 45,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextField(
                    controller: otpControllers[index],
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),

            // Submit button at the bottom of the screen
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: submitOtp,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16),
                ),
                child: const Icon(Icons.arrow_forward),
              ),
            ),
            const SizedBox(
                height:
                    40), // Adding some space to move the button towards the bottom
          ],
        ),
      ),
    );
  }
}
