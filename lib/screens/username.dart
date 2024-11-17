import 'package:flutter/material.dart';

import 'phonenumber.dart';

class NameScreen extends StatelessWidget {
  final Map<String, String> user;

  const NameScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Name Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the name of the user
            TextField(
              controller: TextEditingController(text: user['name']),
              decoration: const InputDecoration(labelText: 'Name'),
              readOnly: true,
            ),
            const SizedBox(height: 20),
            // Submit button to move to Phone Number Screen
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhoneNumberScreen(user: user),
                    ),
                  );
                },
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
