import 'package:flutter/material.dart';

class AudioCallScreen extends StatelessWidget {
  final String userName; // Username passed to the screen
  final String callStatus; // Call status (Calling, Ringing)
  final String audioImage; // Image to display as avatar

  AudioCallScreen({
    required this.userName,
    this.callStatus = 'Calling',
    required this.audioImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Ensure content stays within the screen height
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Spacer(),
                    // Circular avatar image at the center with flexible sizing
                    Flexible(
                      flex: 2,
                      child: CircleAvatar(
                        radius: 100, // Adjust the size of the avatar
                        backgroundImage: AssetImage(audioImage), // User image
                      ),
                    ),
                    SizedBox(height: 6),
                    // User's name
                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Call status (Calling, Ringing)
                    Text(
                      callStatus,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Spacer(),
                    // Bottom interaction buttons
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // End call button
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Color.fromARGB(255, 255, 13, 13),
                            child: IconButton(
                              icon: Icon(Icons.call_end,
                                  size: 28, color: Colors.white),
                              onPressed: () {
                                Navigator.pop(context); // End call action
                              },
                            ),
                          ),
                          // Microphone button
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Color(0xFF2F2F2F),
                            child: IconButton(
                              icon: Icon(Icons.mic_none_outlined,
                                  size: 28, color: Colors.white),
                              onPressed: () {
                                // Handle microphone action
                              },
                            ),
                          ),
                          // Speaker button
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Color(0xFF2F2F2F),
                            child: IconButton(
                              icon: Icon(Icons.volume_up,
                                  size: 28, color: Colors.white),
                              onPressed: () {
                                // Handle speaker action
                              },
                            ),
                          ),
                          // Add user button
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Color(0xFF2F2F2F),
                            child: IconButton(
                              icon: Icon(Icons.person_add_alt_1,
                                  size: 28, color: Colors.white),
                              onPressed: () {
                                // Handle adding a user action
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50), // Add padding to the bottom
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
