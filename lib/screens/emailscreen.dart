// import 'package:flutter/material.dart';

// import 'otpscreen.dart';

// void sendEmailOTP() {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(content: Text('OTP sent to ${widget.user['email']}')),
//   );

//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => OtpScreen(
//         maskedValue: maskEmail(widget.user['email']),
//         onSubmitOtp: (otp) {
//           if (otp == '123456') {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Registration Completed!')),
//             );
//             // Navigate to completion or home page here
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

// // Mask email function
// String maskEmail(String email) {
//   return email.replaceRange(2, email.indexOf('@'), '****');
// }
