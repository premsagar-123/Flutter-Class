import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myproject/Product_shop.dart';
import 'package:myproject/pakistan_study.dart';

const Color bg = Colors.green;
const Color blue = Colors.blue;

InputDecoration input(String hint, IconData icon) => InputDecoration(
  hintText: hint,
  prefixIcon: Icon(icon, color: blue),
  filled: true,
  fillColor: Colors.white,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: blue.withOpacity(0.3)),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: blue.withOpacity(0.3)),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: blue, width: 1.5),
  ),
);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final username = TextEditingController();
  final password = TextEditingController();

  bool visible = false, loading = false;

  Future<void> login() async {
    if (username.text.trim().isEmpty || password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter username and password')),
      );
      return;
    }

    setState(() => loading = true);

    try {
      final res = await http.post(
        Uri.parse('https://dummyjson.com/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username.text.trim(),
          'password': password.text,
        }),
      );

      if (!mounted) return;

      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => ProductScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Login Failed')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Network Error: $e')));
      }
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: bg,
    body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            TextField(
              controller: username,
              decoration: input('Enter your Username', Icons.person),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: password,
              obscureText: !visible,
              decoration: input('Password', Icons.lock).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(visible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => visible = !visible),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: loading ? null : login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                ),
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Log in'),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
              ),
              child: const Text('Forgot password?'),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: OutlinedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignupScreen()),
                ),
                child: const Text('Create new account'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirm = TextEditingController();

  bool loading = false;

  Future<void> signup() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => loading = true);

    try {
      final res = await http.post(
        Uri.parse('https://dummyjson.com/users/add'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username.text.trim(),
          'email': email.text.trim(),
          'password': password.text,
          'firstName': username.text.trim(),
        }),
      );

      if (!mounted) return;

      final data = jsonDecode(res.body);

      if (res.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account Created Successfully!')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Signup Failed')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Network Error: $e')));
      }
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: bg,
    appBar: AppBar(
      title: const Text('Create Account'),
      backgroundColor: blue,
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Text(
              'Create New Account',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: blue,
              ),
            ),
            const SizedBox(height: 25),

            TextFormField(
              controller: username,
              decoration: input('Username', Icons.person),
              validator: (v) => v == null || v.trim().length <= 8
                  ? 'Username must be greater than 8 characters'
                  : null,
            ),
            const SizedBox(height: 15),

            TextFormField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: input('Email', Icons.email),
              validator: (v) =>
                  v == null || !v.contains('@') || !v.contains('.')
                  ? 'Enter a valid email'
                  : null,
            ),
            const SizedBox(height: 15),

            TextFormField(
              controller: password,
              obscureText: true,
              decoration: input('Password', Icons.lock),
              validator: (v) => v == null || v.length <= 8
                  ? 'Password must be greater than 8 characters'
                  : null,
            ),
            const SizedBox(height: 15),

            TextFormField(
              controller: confirm,
              obscureText: true,
              decoration: input('Confirm Password', Icons.lock_outline),
              validator: (v) =>
                  v != password.text ? 'Passwords do not match' : null,
            ),
            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: loading ? null : signup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                ),
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Create Account'),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    ),
  );
}

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final email = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Forgot Password'),
      backgroundColor: blue,
      foregroundColor: Colors.white,
    ),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Your Account',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: email,
            decoration: input('Enter your email', Icons.email),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    email.text.trim().isEmpty
                        ? 'enter your email'
                        : 'Password recovery is a demo only.',
                  ),
                ),
              ),
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    ),
  );
}
