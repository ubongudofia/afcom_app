// lib/screens/chat_screen.dart
import 'package:flutter/material.dart';
import 'chat_detail_screen.dart'; // Assume this is the chat detail screen

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _selectedIndex = 0; // Index of the current active screen (Chat)

  // Sample contact data
  final List<Map<String, String>> _contacts = [
    {
      'name': 'Alice',
      'message': 'Hey, how are you?',
      'timestamp': '10:00 AM',
      'unreadCount': '3',
      'image': 'assets/images/sophia.jpg',
      'bio': 'Creativity Rules the world',
      'phone': '+234 8036073606',
    },
    {
      'name': 'Bob',
      'message': 'See you tomorrow!',
      'timestamp': '09:30 AM',
      'unreadCount': '1',
      'image': 'assets/images/Ubong-Peters1.png',
      'bio': 'Busy',
      'phone': '+234 8036073606',
    },
    {
      'name': 'Charlie',
      'message': 'Let\'s catch up!',
      'timestamp': 'Yesterday',
      'unreadCount': '5',
      'image': 'assets/images/Paul-Emeka1.png',
      'bio': 'busy',
      'phone': '+234 8036073606',
    },
  ];

  // Function to handle bottom navigation bar item tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/chat_screen'); // Chat Screen
        break;
      case 1:
        Navigator.pushNamed(context, '/call_screen'); // Call Screen
        break;
      case 2:
        Navigator.pushNamed(context, '/contact_screen'); // Contact Screen
        break;
      case 3:
        Navigator.pushNamed(context, '/settings_screen'); // Settings Screen
        break;
    }
  }

  // Mock database users
  final List<Map<String, String>> _mockUsers = [
    {
      'name': 'David',
      'bio': 'busy',
      'phone': '+234 8056783936',
      'image': 'assets/images/sophia.jpg'
    },
    {
      'name': 'Emily',
      'bio': 'busy',
      'phone': '+234 8046946936',
      'image': 'assets/images/james.jpg'
    },
    {
      'name': 'Frank',
      'bio': 'busy',
      'phone': '+234 8036073606',
      'image': 'assets/images/steven.jpg'
    },
    {
      'name': 'Grace',
      'bio': 'busy',
      'phone': '+234 8021528390',
      'image': 'assets/images/greg.jpg'
    },
    {
      'name': 'Helen',
      'bio': 'busy',
      'phone': '+234 8010368836',
      'image': 'assets/images/Paul-Emeka1.png'
    },
  ];

  // Function to show the modal bottom sheet with users
  void _showSlidingOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Make it slide all the way up
      backgroundColor:
          Colors.transparent, // Transparent background for the sheet
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false, // Allow manual dragging without forced expansion
          initialChildSize:
              0.75, // Set the initial size to 75% of the screen height
          minChildSize: 0.75, // Minimum size for sliding
          maxChildSize: 1.0, // Maximum size for full-screen
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white, // White background for the sheet
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: ListView(
                controller: scrollController,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'New Chat Options',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.person_add, color: Colors.blue),
                    title: Text('New Contact'),
                    onTap: () {
                      // Handle new contact action
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.group, color: Colors.blue),
                    title: Text('New Group'),
                    onTap: () {
                      // Handle new group action
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.blue),
                    title: Text('Settings'),
                    onTap: () {
                      // Handle settings action
                    },
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Your Contacts',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Display users from the contacts list in the overlay
                  ..._mockUsers.map((contact) => ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(contact['image']!),
                        ),
                        title: Text(contact['name']!),
                        subtitle: Text(contact['bio']!),
                        onTap: () {
                          // Navigate to ChatDetailScreen on contact tap
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChatDetailScreen(contact: contact),
                            ),
                          );
                        },
                      )),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back arrow
        backgroundColor: Colors.white, // White background for AppBar
        elevation: 0, // No shadow for AppBar
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Centered "Chats" title
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Chats',
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
                hintText: 'Search chat',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon:
                    const Icon(Icons.search), // Search icon in the text field
              ),
            ),
          ),
          const SizedBox(height: 20), // Space between search bar and chat list

          // Chat list
          Expanded(
            child: ListView.builder(
              itemCount:
                  _contacts.length, // Use the length of your contacts list
              itemBuilder: (context, index) {
                final chatContact =
                    _contacts[index]; // Access the specific contact
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                        chatContact['image']!), // Load chat contact image
                  ),
                  title: Text(
                    chatContact['name']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${chatContact['message']} - ${chatContact['timestamp']}',
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                      // Unread message count in a circular blue container
                      if (chatContact['unreadCount'] !=
                          '0') // Check if there are unread messages
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape:
                                BoxShape.circle, // Makes the container circular
                          ),
                          child: Text(
                            chatContact['unreadCount']!,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                  onTap: () {
                    // Navigate to chat detail screen on tap
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ChatDetailScreen(contact: _contacts[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

      // Adding a floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: _showSlidingOverlay,
        backgroundColor: Colors.blue, // Blue background color
        foregroundColor: Colors.white, // White icon color
        child: const Icon(Icons.add), // Add icon
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
        selectedIconTheme: const IconThemeData(
            size: 30,
            color: Color.fromARGB(
                255, 14, 95, 133)), // Larger solid icon for active
        unselectedIconTheme: const IconThemeData(
            size: 24, color: Colors.grey), // Regular icon for inactive
      ),
    );
  }
}
