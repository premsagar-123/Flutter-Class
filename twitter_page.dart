import 'package:flutter/material.dart';

class TwitterPage extends StatefulWidget {
  const TwitterPage({super.key});

  @override
  State<TwitterPage> createState() => _TwitterPageState();
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tuiter')),
      body: const Center(child: Text('Welcome to Tuiter')),
    );
  }
}

class _TwitterPageState extends State<TwitterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String savedUsername = '';
  String savedPassword = '';
  bool isSignup = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void login() {
    if (usernameController.text.trim() == savedUsername &&
        passwordController.text == savedPassword &&
        savedUsername.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid username or password! Please sign up first.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void signup() {
    if (usernameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
    } else if (usernameController.text.trim().length <= 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username must be greater than 8 characters'),
        ),
      );
    } else if (passwordController.text.length <= 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password must be greater than 8 characters'),
        ),
      );
    } else if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
    } else {
      savedUsername = usernameController.text.trim();
      savedPassword = passwordController.text;

      usernameController.clear();
      passwordController.clear();
      emailController.clear();
      confirmPasswordController.clear();

      setState(() {
        isSignup = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Signup successful! Please login.'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Twitter",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 85, 188, 236),
                  blurRadius: 40,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.lock_person,
                  size: 70,
                  color: Color.fromARGB(120, 36, 2, 228),
                ),

                Text(
                  isSignup ? "Create Your Account" : "Welcome Back!",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(245, 221, 220, 220),
                  ),
                ),

                Text(
                  isSignup ? "Sign Up" : "Login To Your Account",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 4, 241, 63),
                  ),
                ),

                const SizedBox(height: 25),

                Container(
                  margin: const EdgeInsets.all(8),
                  child: TextField(
                    controller: usernameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Username',
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 206, 120, 7),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                if (isSignup)
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.white70),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color.fromARGB(255, 218, 52, 154),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                Container(
                  margin: const EdgeInsets.all(8),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color.fromARGB(255, 57, 174, 209),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                if (isSignup)
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(color: Colors.white70),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Color.fromARGB(255, 23, 221, 40),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                Container(
                  margin: const EdgeInsets.all(8),
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isSignup ? signup : login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 11, 3, 122),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(isSignup ? 'Create Account' : 'LOGIN'),
                  ),
                ),

                TextButton(
                  onPressed: () {
                    setState(() {
                      isSignup = !isSignup;
                      usernameController.clear();
                      passwordController.clear();
                      emailController.clear();
                      confirmPasswordController.clear();
                    });
                  },
                  child: Text(
                    isSignup
                        ? 'Already have an account? Login'
                        : "Don't have an account? Sign Up",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 168, 39, 129),
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
