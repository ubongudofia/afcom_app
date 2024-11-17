// lib/screens/contact_screen.dart
import 'package:flutter/material.dart';
import '../auth/mockdb.dart'; // Make sure to import the mock database

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  int _selectedIndex = 2; // Index of the current active screen (Contact)

  // Function to handle bottom navigation bar item tap
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
        Navigator.pushNamed(context, '/contact_screen');
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
        backgroundColor: Colors.white, // White background for AppBar
        elevation: 0,
        automaticallyImplyLeading:
            false, // Removes the back arrow // No shadow for AppBar
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Centered "Contacts" title
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Contacts',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon: Icon(Icons.search), // Search icon in the text field
              ),
            ),
          ),
          SizedBox(height: 20), // Space between search bar and contacts

          // Contact list
          Expanded(
            child: ListView(
              children: [
                // Define each user without looping
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                        MockDatabase.users[0]['image']!), // First user
                  ),
                  title: Text(
                    MockDatabase.users[0]['name']!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    MockDatabase.users[0]['bio']!,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      // Add functionality here (e.g., add to favorites)
                    },
                    child: Text('Add'),
                  ),
                ),

                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                        MockDatabase.users[1]['image']!), // Second user
                  ),
                  title: Text(
                    MockDatabase.users[1]['name']!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    MockDatabase.users[1]['bio']!,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      // Add functionality here (e.g., add to favorites)
                    },
                    child: Text('Add'),
                  ),
                ),

                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                        MockDatabase.users[2]['image']!), // Third user
                  ),
                  title: Text(
                    MockDatabase.users[2]['name']!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    MockDatabase.users[2]['bio']!,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      // Add functionality here (e.g., add to favorites)
                    },
                    child: Text('Add'),
                  ),
                ),

                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                        MockDatabase.users[3]['image']!), // Fourth user
                  ),
                  title: Text(
                    MockDatabase.users[3]['name']!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    MockDatabase.users[3]['bio']!,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      // Add functionality here (e.g., add to favorites)
                    },
                    child: Text('Add'),
                  ),
                ),

                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                        MockDatabase.users[4]['image']!), // Fifth user
                  ),
                  title: Text(
                    MockDatabase.users[4]['name']!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    MockDatabase.users[4]['bio']!,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      // Add functionality here (e.g., add to favorites)
                    },
                    child: Text('Add'),
                  ),
                ),

                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                        MockDatabase.users[5]['image']!), // Sixth user
                  ),
                  title: Text(
                    MockDatabase.users[5]['name']!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    MockDatabase.users[5]['bio']!,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      // Add functionality here (e.g., add to favorites)
                    },
                    child: Text('Add'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFEDF2FA), // Light grey background
        type: BottomNavigationBarType.fixed, // Fixed navigation bar
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
        currentIndex: _selectedIndex, // The current active index
        onTap: _onItemTapped, // Handle item tap
        selectedItemColor:
            const Color.fromARGB(255, 14, 95, 133), // Active color (blue)
        unselectedItemColor: Colors.grey, // Inactive icons and text color
        showUnselectedLabels: true, // Show text labels for inactive items
        selectedIconTheme: IconThemeData(
          size: 30,
          color: Color.fromARGB(255, 14, 95, 133),
        ), // Larger solid icon for active
        unselectedIconTheme: IconThemeData(
          size: 24,
          color: Colors.grey,
        ), // Regular icon for inactive
      ),
    );
  }
}
