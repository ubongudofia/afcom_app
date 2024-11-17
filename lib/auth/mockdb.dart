//import 'package:flutter/material.dart';

// lib/mock_data.dart
class MockDatabase {
  static List<Map<String, String>> users = [
    {
      'service_number': 'DSA/CIV/0245',
      'name': 'UBONG UDOFIA',
      'email': 'udofiaubong10@gmail.com',
      'phone': '07584486754',
      'password': 'password123',
      'bio': 'Creative designer with a passion for aesthetics.',
      'image': 'assets/images/Paul-Emeka1.png',
    },
    {
      'service_number': 'DSA/CIV/0246',
      'name': 'John Smith',
      'email': 'john@example.com',
      'phone': '0987654321',
      'password': 'mypassword456',
      'bio': 'Tech enthusiast and full-stack developer.',
      'image': 'assets/images/greg.jpg',
    },
    {
      'service_number': 'DSA/CIV/0247',
      'name': 'Sophia Turner',
      'email': 'sophia@example.com',
      'phone': '1122334455',
      'password': 'sophiapass789',
      'bio': 'Marketing specialist with a knack for social media.',
      'image': 'assets/images/sophia.jpg',
    },
    {
      'service_number': 'DSA/CIV/0248',
      'name': 'James Lee',
      'email': 'james@example.com',
      'phone': '6677889900',
      'password': 'jamespass321',
      'bio': 'Data scientist who loves crunching numbers.',
      'image': 'assets/images/james.jpg',
    },
    {
      'service_number': 'DSA/CIV/0249',
      'name': 'Emma Davis',
      'email': 'emma@example.com',
      'phone': '4455667788',
      'password': 'emmadavis999',
      'bio': 'HR manager with 10 years of experience.',
      'image': 'assets/images/Ubong-Peters1.png',
    },
    {
      'service_number': 'DSA/CIV/0250',
      'name': 'Chris Evans',
      'email': 'chris@example.com',
      'phone': '1234567890',
      'password': 'chrispass987',
      'bio': 'Software engineer who loves open-source.',
      'image': 'assets/images/james.jpg',
    },
    {
      'service_number': 'DSA/CIV/0251',
      'name': 'Alice Johnson',
      'email': 'alice@example.com',
      'phone': '2233445566',
      'password': 'alicepass654',
      'bio': 'Digital marketer with 5 years experience.',
      'image': 'assets/images/steven.jpg',
    },
    {
      'service_number': 'DSA/CIV/0252',
      'name': 'Michael Brown',
      'email': 'michael@example.com',
      'phone': '3344556677',
      'password': 'michaelpass321',
      'bio': 'Project manager and agile enthusiast.',
      'image': 'assets/images/Ubong-Peters1.png',
    },
    {
      'service_number': 'DSA/CIV/0253',
      'name': 'Olivia Williams',
      'email': 'olivia@example.com',
      'phone': '5566778899',
      'password': 'oliviapass000',
      'bio': 'UX/UI designer with a passion for creating intuitive designs.',
      'image': 'assets/images/greg.jpg',
    },
    {
      'service_number': 'DSA/CIV/0254',
      'name': 'David Miller',
      'email': 'david@example.com',
      'phone': '7788990011',
      'password': 'davidpass222',
      'bio': 'DevOps engineer and cloud enthusiast.',
      'image': 'assets/images/Paul-Emeka1.png',
    }
  ];

  static Map<String, String>? findUserByServiceNumber(String serviceNumber) {
    return users.firstWhere(
      (user) => user['service_number'] == serviceNumber,
      orElse: () => <String, String>{}, // Return an empty map instead of null
    );
  }

  static Map<String, String>? findUserByName(String name) {
    return users.firstWhere(
      (user) => user['name'] == name,
      orElse: () => <String, String>{}, // Return empty map if user not found
    );
  }

  static getUsers() {}
}
