import 'package:flutter/material.dart';

import 'user_controller.dart';

class ShowData extends StatefulWidget {
  const ShowData({super.key});

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  final userController = UserController();

  @override
  void initState() {
    super.initState();

    userController.addListener(() {
      setState(() {});
    });

    userController.fetchUserData();
  }

  @override
  void dispose() {
    userController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: userController.user == null
            ? const CircularProgressIndicator()
            : Text(
                'Name: ${userController.user!.name}\nEmail: ${userController.user!.email}\nImage: ${userController.user!.image}\nGender: ${userController.user!.gender}\nPhone: ${userController.user!.phone}\nLast Name: ${userController.user!.lastName}',
              ),
      ),
    );
  }
}
