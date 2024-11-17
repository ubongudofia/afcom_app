import 'package:flutter/material.dart';
import './mockdb.dart';

class ServiceNumberScreen extends StatefulWidget {
  const ServiceNumberScreen({Key? key}) : super(key: key);

  @override
  _ServiceNumberScreenState createState() => _ServiceNumberScreenState();
}

class _ServiceNumberScreenState extends State<ServiceNumberScreen> {
  final TextEditingController _serviceNumberController =
      TextEditingController();
  bool _isFieldEmpty = false;

  void _checkUser() {
    String serviceNumber = _serviceNumberController.text.trim();

    if (serviceNumber.isEmpty) {
      setState(() {
        _isFieldEmpty = true;
      });
      _showEmptyServiceNumberDialog();
    } else {
      if (!serviceNumber.startsWith('DSA/CIV/')) {
        serviceNumber = 'DSA/CIV/$serviceNumber';
      }

      final user = MockDatabase.findUserByServiceNumber(serviceNumber);

      if (user != null && user.isNotEmpty) {
        Navigator.pushNamed(context, '/name', arguments: user);
      } else {
        _showUserNotFoundDialog();
      }
    }
  }

  void _showUserNotFoundDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('User Not Found'),
          content:
              const Text('No user found with the provided service number.'),
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

  void _showEmptyServiceNumberDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Please enter your service number.'),
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFE6F2FF), // Body background color
        appBar: AppBar(
          backgroundColor: const Color(0xFFE6F2FF),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                color: const Color(0xFF0D6EFF)), // White arrow color
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 150, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // White container with rounded corners
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
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
                      'Enter Your Service Number',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
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
                        border: Border.all(
                          color:
                              _isFieldEmpty ? Colors.red : Colors.transparent,
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: TextField(
                        controller: _serviceNumberController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Service Number',
                        ),
                        keyboardType: TextInputType.text,
                        onChanged: (text) {
                          setState(() {
                            _isFieldEmpty = text.trim().isEmpty;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 400), // Pushes the button to the bottom
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: _checkUser,
                  backgroundColor: const Color.fromARGB(255, 14, 95, 133),
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
