import 'package:flutter/material.dart';

class AzazonPage extends StatefulWidget {
  const AzazonPage({super.key});

  @override
  State<AzazonPage> createState() => _AzazonPageState();
}

class _AzazonPageState extends State<AzazonPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Amazon",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 233, 189, 47),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 8, 6, 6),
        foregroundColor: const Color.fromARGB(255, 223, 93, 184),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 3, 1, 145),
                  blurRadius: 50,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.lock_person,
                  size: 70,
                  color: Color.fromARGB(255, 107, 3, 126),
                ),
                const SizedBox(height: 15),
                const Text(
                  "WellCome Back!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.amberAccent,
                  ),
                ),
                const Text(
                  "Login Your Acount",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 6, 221, 42),
                  ),
                ),

                const SizedBox(height: 15),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email Address",
                    prefixIcon: Icon(Icons.email, color: Colors.pink),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock, color: Colors.amberAccent),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Login"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 240, 236, 237),
                      foregroundColor: const Color.fromARGB(255, 54, 9, 236),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
