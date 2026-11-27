import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.apps, color: Colors.yellow),
        ),
        centerTitle: true,
        title: const Text(
          'Sagar King 👋 ',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.amberAccent,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add, color: Colors.amberAccent),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 8, 7, 7),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/back_ground.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(23),
            child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 13, 245, 33),
                    blurRadius: 70,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.lock_person_outlined,
                    color: Colors.amberAccent,
                    size: 70,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color.fromARGB(255, 16, 248, 8),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 204, 18),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.amberAccent),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Password',
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color.fromARGB(255, 243, 6, 6),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 7, 248, 67),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 240, 9, 182),
                        ),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 250, 28, 76),
                      foregroundColor: const Color.fromARGB(255, 229, 245, 14),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      backgroundColor: const Color.fromARGB(255, 232, 255, 22),
    );
  }
}
