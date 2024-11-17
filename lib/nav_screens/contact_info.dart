import 'package:flutter/material.dart';
import './audio_call_screen.dart';
import './video_call_screen.dart';

class ContactInfo extends StatelessWidget {
  final Map<String, String> contact;

  const ContactInfo({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Contact info", style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: const Color(0xFF2196F3),
        iconTheme: const IconThemeData(
            color: Colors.white), // Back arrow color set to white
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Display contact's profile image with a default placeholder
              Center(
                child: CircleAvatar(
                  radius: 75,
                  backgroundImage: contact['image'] != null
                      ? AssetImage(contact['image']!)
                      : const AssetImage('assets/default_profile.png'),
                ),
              ),
              const SizedBox(height: 10),

              // Display contact's name with a fallback value
              Text(
                contact['name'] ?? 'No Name Provided',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              // Display contact's phone number with a fallback value
              Text(
                contact['phone'] ?? 'No Phone Number',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Row with icons for call, video call, and search
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildIconButton(
                    icon: Icons.call,
                    label: 'Call',
                    iconColor: const Color(0xFF2196F3), // Icon color
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AudioCallScreen(
                                  audioImage: contact['image']!,
                                  userName: contact['name']!,
                                  callStatus: 'Calling',
                                )),
                      );
                    },
                  ),
                  _buildIconButton(
                    icon: Icons.videocam,
                    label: 'Video Call',
                    iconColor: const Color(0xFF2196F3), // Icon color
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideoCallScreen(
                                  videoImage: contact['image']!,
                                  userName: contact['name']!,
                                  callStatus: 'Calling',
                                )),
                      );
                    },
                  ),
                  _buildIconButton(
                    icon: Icons.search,
                    label: 'Search',
                    iconColor: const Color(0xFF2196F3), // Icon color
                    onPressed: () {
                      // Add your onPressed functionality for Search here
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Bio container, aligned to the left with the same width as other containers
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  contact['bio'] ?? 'No Bio Available',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // First container with setting options
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    _buildSettingOption(Icons.notifications, 'Notifications',
                        onPressed: () {
                      // Navigate to Notifications screen
                    }),
                    _buildSettingOption(Icons.photo, 'Media', onPressed: () {
                      // Navigate to Media screen
                    }),
                    _buildSettingOption(Icons.lock, 'Lock Chats',
                        onPressed: () {
                      // Navigate to Lock Chats screen
                    }),
                    _buildSettingOption(Icons.save_alt, 'Save to Photos',
                        onPressed: () {
                      // Navigate to Save to Photos screen
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Second container with setting options
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    _buildSettingOption(Icons.contact_phone, 'Contact Details',
                        onPressed: () {
                      // Navigate to Contact Details screen
                    }),
                    _buildSettingOption(Icons.share, 'Share Contact',
                        onPressed: () {
                      // Navigate to Share Contact screen
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF8F8FA),
    );
  }

  // Widget for icons with labels underneath, now includes an onPressed function, custom icon color, and white circular background
  Widget _buildIconButton(
      {required IconData icon,
      required String label,
      required Color iconColor,
      required VoidCallback onPressed}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white, // Background color set to white
          child: IconButton(
            icon: Icon(icon,
                color: iconColor, size: 30), // Icon color set to #21963
            onPressed: onPressed,
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.blue)),
      ],
    );
  }

  // Widget for each setting option, now includes an onPressed function
  Widget _buildSettingOption(IconData icon, String label,
      {required VoidCallback onPressed}) {
    return ListTile(
      leading: Icon(icon,
          color: const Color(0xFF2196F3)), // Set icon color to #21963
      title: Text(label),
      trailing: const Icon(Icons.arrow_forward_ios,
          color: Colors.grey), // Trailing arrow color set to grey
      onTap: onPressed, // Make each setting option clickable
    );
  }
}
