import 'dart:io' if (kIsWeb) 'dart:html'; // Handles platform compatibility
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart'; // Not supported for web
import 'package:record/record.dart'; // Correct package usage
import 'package:audioplayers/audioplayers.dart'; // For playing audio on both web and mobile
import 'package:path/path.dart' as p;

import './audio_call_screen.dart';
import './video_call_screen.dart';
import './contact_info.dart';

class ChatDetailScreen extends StatefulWidget {
  final Map<String, String> contact;

  const ChatDetailScreen({Key? key, required this.contact}) : super(key: key);

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  final AudioPlayer _audioPlayer = AudioPlayer(); // For playback
  String? recordingPath;
  bool _isRecording = false;
  bool _isPlaying = false; // Track whether the audio is playing

  @override
  void initState() {
    super.initState();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.minScrollExtent);
      }
    });
  }

// Function to start/stop audio recording
  Future<void> _toggleRecording() async {
    if (kIsWeb) {
      print("Audio recording is not supported on the web.");
      return;
    }

    // Handle recording for mobile (non-web)
    if (_isRecording) {
      final path = await AudioRecorder().stop();
      if (path != null) {
        setState(() {
          _isRecording = false;
          recordingPath = path;
          _messages.add({
            'type': 'audio',
            'filePath': path,
            'isSent': true,
            'timestamp': DateTime.now().toLocal().toString().substring(11, 16),
          });
        });
      }
    } else {
      // Request microphone permissions and start recording
      if (await AudioRecorder().hasPermission()) {
        final Directory appDocumentsDir =
            await getApplicationDocumentsDirectory();
        final String filePath =
            p.join(appDocumentsDir.path, "recording.m4a"); // Use .m4a

        // Start recording, passing the file path as the first positional argument
        await AudioRecorder().start(filePath as RecordConfig, path: '');
        setState(() {
          _isRecording = true;
          recordingPath = null;
        });
      }
    }
  }

  // Function to play the audio file
  Future<void> _playAudio(String filePath) async {
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        if (kIsWeb) {
          await _audioPlayer.setSourceUrl(filePath); // For web
        } else {
          await _audioPlayer.setSourceDeviceFile(filePath); // For mobile
        }
        await _audioPlayer.resume(); // Start playing the audio
      }
      setState(() {
        _isPlaying = !_isPlaying; // Toggle play/pause state
      });
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

// Function to handle file attachments

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: true,
    );

    if (result != null) {
      final fileName = result.files.first.name;

      if (kIsWeb) {
        final fileBytes = result.files.first.bytes; // Use this for web

        if (fileBytes != null) {
          setState(() {
            _handleFileDisplay(
                fileBytes: fileBytes, fileName: fileName); // For web
          });
        }
      } else {
        final filePath = result.files.first.path; // Use this for mobile

        if (filePath != null) {
          setState(() {
            _handleFileDisplay(
                filePath: filePath, fileName: fileName); // For mobile
          });
        }
      }
    }
  }

// Handle file display or processing
  void _handleFileDisplay(
      {Uint8List? fileBytes, String? filePath, required String fileName}) {
    String? fileFormat = p.extension(fileName).toUpperCase();
    String timestamp = DateTime.now().toLocal().toString().substring(11, 16);

    if (kIsWeb && fileBytes != null) {
      // Handle file display for web using fileBytes
      if (['.JPG', '.JPEG', '.PNG'].contains(fileFormat)) {
        _messages.add({
          'type': 'image',
          'fileBytes': fileBytes, // Use bytes for images on web
          'fileName': fileName,
          'timestamp': timestamp,
        });
      } else if (fileFormat == '.MP4') {
        _messages.add({
          'type': 'video',
          'fileBytes': fileBytes, // Use bytes for videos on web
          'fileName': fileName,
          'timestamp': timestamp,
        });
      } else if (['.PDF', '.DOCX', '.XLSX'].contains(fileFormat)) {
        _messages.add({
          'type': 'document',
          'fileBytes': fileBytes, // Use bytes for documents on web
          'fileName': fileName,
          'timestamp': timestamp,
        });
      }
    } else if (!kIsWeb && filePath != null) {
      // Handle file display for mobile using filePath
      if (['.JPG', '.JPEG', '.PNG'].contains(fileFormat)) {
        _messages.add({
          'type': 'image',
          'filePath': filePath, // Use path for images on mobile
          'timestamp': timestamp,
        });
      } else if (fileFormat == '.MP4') {
        _messages.add({
          'type': 'video',
          'filePath': filePath, // Use path for videos on mobile
          'fileName': fileName,
          'timestamp': timestamp,
        });
      } else if (['.PDF', '.DOCX', '.XLSX'].contains(fileFormat)) {
        _messages.add({
          'type': 'document',
          'filePath': filePath, // Use path for documents on mobile
          'fileName': fileName,
          'timestamp': timestamp,
        });
      }
    }
  }

  // Function to simulate message sending
  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add({
          'text': text,
          'isSent': true,
          'type': 'text',
          'timestamp': DateTime.now().toLocal().toString().substring(11, 16),
        });
      });
      _messageController.clear();

      // Add the "Got your message!" response after 1-second delay
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _messages.add({
            'text': 'Got your message!',
            'isSent': false,
            'type': 'text',
            'timestamp': DateTime.now().toLocal().toString().substring(11, 16),
          });
        });
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _audioPlayer
        .dispose(); // Dispose of the AudioPlayer when the screen is closed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF2196F3),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: GestureDetector(
            onTap: () {
              // Navigate to the ContactInfo screen when tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactInfo(contact: widget.contact),
                ),
              );
            },
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(widget.contact['image']!),
                ),
                const SizedBox(width: 10),
                Text(
                  widget.contact['name']!,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.call_outlined, color: Colors.white),
              onPressed: () {
                String userName = widget.contact['name']!;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AudioCallScreen(
                      audioImage: widget.contact['image']!,
                      userName: userName,
                      callStatus: 'Calling',
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.videocam_outlined, color: Colors.white),
              onPressed: () {
                String userName = widget.contact['name']!;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoCallScreen(
                      videoImage: widget.contact['image']!,
                      userName: userName,
                      callStatus: 'Calling',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  reverse: false,
                  controller: _scrollController,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return _buildMessageBubble(message);
                  },
                ),
              ),
            ),
            _buildMessageInput(),
          ],
        ));
  }

// Build different types of message bubbles
  Widget _buildMessageBubble(Map<String, dynamic> message) {
    bool isSent = message['isSent'] ?? true;
    String timestamp = message['timestamp'];

    // Handle Text Message
    if (message['type'] == 'text') {
      return Align(
        alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSent ? Colors.blue : Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message['text'],
                style: TextStyle(color: isSent ? Colors.white : Colors.black),
              ),
              const SizedBox(height: 4),
              Text(
                timestamp,
                style: const TextStyle(fontSize: 10, color: Colors.white70),
              ),
            ],
          ),
        ),
      );
    }

    // Handle Image Message
    else if (message['type'] == 'image') {
      return Align(
        alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
              isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: kIsWeb
                  ? Image.memory(message['fileBytes']!, width: 150, height: 150)
                  : Image.file(File(message['filePath']!),
                      width: 150, height: 150),
            ),
            Text(timestamp,
                style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      );
    }

    // Handle Video Message
    else if (message['type'] == 'video') {
      return Align(
        alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
              isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                OpenFile.open(message['filePath']); // Opens the video file
              },
              child: Row(
                children: [
                  Icon(Icons.video_collection),
                  const SizedBox(width: 8),
                  Text(
                    message['fileName'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Text("${message['fileSize']} | ${message['duration']}",
                style: const TextStyle(fontSize: 10, color: Colors.grey)),
            Text(timestamp,
                style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      );
    }

    // Handle Document Message (PDF, DOCX, XLSX)
    else if (message['type'] == 'document') {
      return Align(
        alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
              isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                OpenFile.open(message['filePath']); // Opens the document file
              },
              child: Row(
                children: [
                  Icon(Icons.insert_drive_file),
                  const SizedBox(width: 8),
                  Text(
                    message['fileName'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Text("${message['fileSize']} | ${message['fileFormat']}",
                style: const TextStyle(fontSize: 10, color: Colors.grey)),
            Text(timestamp,
                style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      );
    }

    // Handle Audio Message
    // Extend _buildMessageBubble to handle audio messages
    else if (message['type'] == 'audio') {
      return Align(
        alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
              isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                    onPressed: () => _playAudio(message['filePath']),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Audio Message',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Text(timestamp,
                style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      );
    }

    // Return an empty container if no matching type
    return Container();
  }

  // Input field and buttons for sending messages
// Build the message input bar with text input and microphone icon
  Widget _buildMessageInput() {
    return Container(
      color: Color(0xFFEDF2FA), // Sets the background color to #EDF2FA
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              _isRecording ? Icons.stop : Icons.mic,
              color: _isRecording ? Colors.red : Colors.blue,
            ),
            onPressed: _toggleRecording,
          ),
          IconButton(
            icon: const Icon(Icons.attach_file, color: Colors.blue),
            onPressed: _pickFile,
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
