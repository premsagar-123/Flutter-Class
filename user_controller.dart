import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserController extends ChangeNotifier {
  UserModel? user;

  Future<void> fetchUserData() async {
    try {
      const url = 'https://dummyjson.com/user/1';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        user = UserModel.fromJson(data);
        notifyListeners();
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      debugPrint('Error fetching user data: $e');
    }
  }
}

class UserModel {
  final int id;
  final String name;
  final String email;
  final String image;
  final String gender;
  final String phone;
  final String lastName;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.gender,
    required this.phone,
    required this.lastName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final firstName = json['firstName'] ?? '';
    final lastNameValue = json['lastName'] ?? '';

    return UserModel(
      id: json['id'] ?? 0,
      name: '$firstName $lastNameValue'.trim(),
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      gender: json['gender'] ?? '',
      phone: json['phone'] ?? '',
      lastName: lastNameValue,
    );
  }
}
