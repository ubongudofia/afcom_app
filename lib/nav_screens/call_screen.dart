import 'package:flutter/material.dart';
import './video_call_screen.dart';
import './audio_call_screen.dart';

class CallScreen extends StatefulWidget {
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  int _selectedIndex = 1; // Index for Call Screen

  // Sample call log data
  final List<Map<String, String>> _callLogs = [
    {
      'name': 'Alice',
      'time': 'Yesterday, 10:30 AM',
      'status': 'Missed',
      'image': 'assets/images/Ubong-Peters1.png'
    },
    {
      'name': 'Bob',
      'time': 'Today, 8:00 AM',
      'status': 'Incoming',
      'image': 'assets/images/Paul-Emeka1.png'
    },
    {
      'name': 'Charlie',
      'time': 'Today, 6:00 AM',
      'status': 'Outgoing',
      'image': 'assets/images/greg.jpg'
    },
  ];

  // Users for mock call selection
  final List<Map<String, String>> _mockUsers = [
    {'name': 'David', 'image': 'assets/images/james.jpg'},
    {'name': 'Eva', 'image': 'assets/images/Sophia.jpg'},
    {'name': 'Frank', 'image': 'assets/images/Steven.jpg'},
  ];

  List<Map<String, String>> _selectedUsers =
      []; // Store selected users for a call

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
        Navigator.pushNamed(context, '/contact_screen');
        break;
      case 3:
        Navigator.pushNamed(context, '/settings_screen');
        break;
    }
  }

  // Sliding up modal to select users for a call
  void _openSlidingUpModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize:
              0.75, // Set the initial size to 75% of the screen height
          minChildSize: 0.75, // Minimum size for sliding
          maxChildSize: 1.0,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // New Call Options at the top of the overlay
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'New Call Options',
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

                  // Selected users displayed on top of the overlay
                  if (_selectedUsers.isNotEmpty)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _selectedUsers.map((user) {
                          return Stack(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundImage: AssetImage(user['image']!),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedUsers.remove(user);
                                    });
                                  },
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.red,
                                    child: Icon(Icons.close,
                                        size: 14, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  const SizedBox(height: 16),

                  // List of mock users to select for the call
                  Text('Add Call',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: _mockUsers.length,
                      itemBuilder: (context, index) {
                        final user = _mockUsers[index];
                        bool isSelected = _selectedUsers.contains(user);
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(user['image']!),
                          ),
                          title: Text(user['name']!),
                          trailing: Checkbox(
                            shape:
                                CircleBorder(), // Changed checkbox shape to circular
                            value: isSelected,
                            onChanged: (bool? value) {
                              setState(() {
                                if (value == true) {
                                  _selectedUsers.add(user);
                                } else {
                                  _selectedUsers.remove(user);
                                }
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
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
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Calls',
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
                prefixIcon:
                    const Icon(Icons.search), // Search icon in the text field
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: TextField(
          //     decoration: InputDecoration(
          //       hintText: 'Search name',
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(10.0),
          //       ),
          //       prefixIcon: const Icon(Icons.search),
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 10), // Space between search bar and contacts

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent calls',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Display recent calls using ListView.builder
          Expanded(
            child: ListView.builder(
              itemCount: _callLogs.length,
              itemBuilder: (context, index) {
                final callLog = _callLogs[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage(callLog['image']!),
                      ),
                      const SizedBox(
                          width: 16), // Spacing between image and text
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              callLog['name']!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              callLog['status']!,
                              style: TextStyle(
                                color: _getCallStatusColor(callLog['status']!),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              callLog['time']!,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.call,
                                color: Colors.green), // The video call icon
                            onPressed: () {
                              // Assuming `selectedUser` is the user currently selected or in the call
                              String userName =
                                  callLog['name']!; // Get the name dynamically

                              // Navigate to VideoCallScreen with the dynamically retrieved name
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AudioCallScreen(
                                    audioImage: callLog['image']!,
                                    userName: userName,
                                    callStatus: 'Calling',
                                  ),
                                ),
                              );
                            },
                          ),

                          const SizedBox(width: 10),
                          // Your current call screen
                          IconButton(
                            icon: Icon(Icons.videocam,
                                color: Colors.blue), // Video call button
                            onPressed: () {
                              String userName = callLog['name']!;

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VideoCallScreen(
                                    videoImage: callLog['image']!,
                                    userName: userName,
                                    callStatus:
                                        'Calling', // Example: Change status as needed
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openSlidingUpModal(context),
        backgroundColor: Colors.blue,
        child: Icon(Icons.add_call, color: Colors.white),
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

  // Method to get call status color
  Color _getCallStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'missed':
        return Colors.red;
      case 'incoming':
        return Colors.green;
      case 'outgoing':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
