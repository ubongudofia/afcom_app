import 'package:flutter/material.dart';

class VideoCallScreen extends StatelessWidget {
  final String userName; // Username passed to the screen
  final String callStatus; // Call status (Calling, Ringing)
  final String videoImage; // Image to display as avatar

  VideoCallScreen({
    required this.userName,
    this.callStatus = 'Calling',
    required this.videoImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background image in the scaffold
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(videoImage), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay for video call UI elements
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // AppBar with user's name and status
              AppBar(
                automaticallyImplyLeading: false, // Removes the back arrow
                backgroundColor: Colors.transparent, // Transparent background
                elevation: 0, // No shadow
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        userName,
                        style: TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                      child: Text(
                        callStatus, // Either 'Calling' or 'Ringing'
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              // Bottom controls for call interaction
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 40.0), // Padding for the bottom controls
                child: BottomAppBar(
                  color: Colors.transparent, // Make bottom app bar transparent
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // End call button
                      Flexible(
                        child: CircleAvatar(
                          radius: 35, // Reduced radius for better fit
                          backgroundColor: Color.fromARGB(255, 255, 13, 13),
                          child: IconButton(
                            icon: Icon(
                              Icons.call_end,
                              size: 28, // Adjusted icon size
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context); // Handle button press
                            },
                          ),
                        ),
                      ),
                      // Recording button
                      Flexible(
                        child: CircleAvatar(
                          radius: 35, // Reduced radius for better fit
                          backgroundColor: Color(0xFF2F2F2F),
                          child: IconButton(
                            icon: Icon(
                              Icons.mic_none_outlined,
                              size: 28, // Adjusted icon size
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Handle button press
                            },
                          ),
                        ),
                      ),
                      // Speaker button
                      Flexible(
                        child: CircleAvatar(
                          radius: 35, // Reduced radius for better fit
                          backgroundColor: Color(0xFF2F2F2F),
                          child: IconButton(
                            icon: Icon(
                              Icons.volume_up,
                              size: 28, // Adjusted icon size
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Handle button press
                            },
                          ),
                        ),
                      ),
                      // Video call cancel icon
                      Flexible(
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: Color(0xFF2F2F2F),
                          child: IconButton(
                            icon: Icon(
                              Icons.videocam_off,
                              size: 28, // Adjusted icon size
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Handle video cancel
                            },
                          ),
                        ),
                      ),
                      // Add user to call
                      Flexible(
                        child: CircleAvatar(
                          radius: 35, // Reduced radius for better fit
                          backgroundColor: Color(0xFF2F2F2F),
                          child: IconButton(
                            icon: Icon(
                              Icons.person_add_alt_1,
                              size: 28, // Adjusted icon size
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Handle add user action
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
