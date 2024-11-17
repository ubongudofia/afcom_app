import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedIndex = 3; // Index for Settings Screen

  // Handle navigation on the bottom bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/chat_screen');
        break;
      case 1:
        Navigator.pushNamed(context, '/call_screen');
        break;
      case 2:
        Navigator.pushNamed(context, '/contact_screens');
        break;
      case 3:
        Navigator.pushNamed(context, '/settings_screen');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
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
                  backgroundImage:
                      AssetImage('assets/images/Ubong-Peters1.png'),
                ),
              ),
              const SizedBox(height: 10),

              // Display contact's name with a fallback value
              Text(
                'UBONG UDOFIA',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              // Display contact's phone number with a fallback value
              Text(
                '+234 709 6784 945',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
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
                  'In God I put my Trust',
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFEDF2FA),
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Call',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color.fromARGB(255, 14, 95, 133),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedIconTheme:
            IconThemeData(size: 30, color: Color.fromARGB(255, 14, 95, 133)),
        unselectedIconTheme: IconThemeData(size: 24, color: Colors.grey),
      ),
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
