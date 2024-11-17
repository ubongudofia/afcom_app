// import 'package:flutter/material.dart';

// import 'otpscreen.dart';
// import 'email.dart';

// void sendOTP() {
//   // Simulate sending OTP and then navigate to the OTP input screen
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(content: Text('OTP sent to ${widget.user['phone_number']}')),
//   );

//   // Navigate to OTP screen for phone number
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => OtpScreen(
//         maskedValue: maskPhoneNumber(widget.user['phone_number']),
//         onSubmitOtp: (otp) {
//           if (otp == '123456') {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => EmailScreen(user: widget.user),
//               ),
//             );
//           } else {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Invalid OTP. Please try again.')),
//             );
//           }
//         },
//       ),
//     ),
//   );
// }

// // Mask phone number function
// String maskPhoneNumber(String phoneNumber) {
//   return phoneNumber.replaceRange(0, 7, '1233****'); // Example masking
// }
