import 'package:flutter/material.dart';

class PasswordSetupScreen extends StatefulWidget {
  const PasswordSetupScreen({Key? key}) : super(key: key);

  @override
  _PasswordSetupScreenState createState() => _PasswordSetupScreenState();
}

class _PasswordSetupScreenState extends State<PasswordSetupScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypePasswordController =
      TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _retypePasswordFocusNode = FocusNode();

  void _signIn() {
    final password = _passwordController.text;
    final retypePassword = _retypePasswordController.text;

    // Perform authentication check here
    if (password.isEmpty || retypePassword.isEmpty) {
      _showErrorDialog('Fields cannot be empty');
      return;
    }

    if (password != retypePassword) {
      _showErrorDialog('Passwords do not match');
      return;
    }

    // If authentication is successful, navigate to the contact screen
    Navigator.pushReplacementNamed(
        context, '/contact_screens'); // Navigate to Contact Screen
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Name input
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(16),
                ),
                controller: TextEditingController(text: user['name']),
                readOnly: true,
              ),
              const SizedBox(height: 20),

              // Password input
              TextField(
                controller: _passwordController,
                obscureText: true,
                focusNode: _passwordFocusNode,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(16),
                ),
                onSubmitted: (_) {
                  // Move focus to the next field when done
                  FocusScope.of(context).requestFocus(_retypePasswordFocusNode);
                },
              ),
              const SizedBox(height: 20),

              // Re-type Password input
              TextField(
                controller: _retypePasswordController,
                obscureText: true,
                focusNode: _retypePasswordFocusNode,
                decoration: const InputDecoration(
                  labelText: 'Re-type Password',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 30),

              // Full-width Sign In button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _signIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 14, 95, 133), // Background color
                    padding: const EdgeInsets.symmetric(vertical: 24),
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
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
