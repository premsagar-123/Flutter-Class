import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class UserController extends ChangeNotifier {
  UserModel? user;

  Future<void> fetchUserData() async {
    try {
      String url = 'https://dummyjson.com/user/1';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        user = UserModel.fromJson(data);
        notifyListeners();
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
}

class UserModel {
  final Map<String, dynamic> data;

  UserModel.fromJson(Map<String, dynamic> json) : data = json;
}
