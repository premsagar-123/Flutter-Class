import 'package:flutter/material.dart';

class LivePage extends StatelessWidget {
  const LivePage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Google Account",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 21, 116, 2),
          ),
        ),
        backgroundColor: const Color.fromARGB(31, 12, 9, 9),

        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(23),
              boxShadow: const [
                BoxShadow(
                  color: Colors.pink,
                  blurRadius: 50,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 100,

                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.lock_person_outlined,
                      color: Color.fromARGB(255, 185, 2, 103),
                      size: 70,
                    ),
                  ),
                ),
                const Text(
                  "Wellcome Back",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: Column(
                      children: [
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email, color: Colors.orange),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  child: TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(
                        Icons.password_outlined,
                        color: Colors.pink,
                      ),
                    ),
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(20, 44, 1, 231),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
