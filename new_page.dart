import 'package:flutter/material.dart';
import 'package:myproject/pakistan_study.dart';

class PakStudy extends StatefulWidget {
  const PakStudy({super.key});

  @override
  State<PakStudy> createState() => _PakStudyState();
}

class _PakStudyState extends State<PakStudy> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String savedUsername = '';
  String savedPassword = '';

  bool isSignup = false;
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void showMessage(String message, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  void login() {
    final username = usernameController.text.trim();
    final password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      showMessage('Please enter username and password!');
      return;
    }

    if (savedUsername.isEmpty || savedPassword.isEmpty) {
      showMessage('Please create an account first!');
      return;
    }

    if (username == savedUsername && password == savedPassword) {
      showMessage('Login successful!', success: true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PakistanStudyPage()),
      );
    } else {
      showMessage('Invalid username or password!');
    }
  }

  void signup() {
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showMessage('Please fill all fields!');
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      showMessage('Please enter a valid email!');
      return;
    }

    if (username.length <= 8) {
      showMessage('Username must be greater than 8 characters!');
      return;
    }

    if (password.length <= 8) {
      showMessage('Password must be greater than 8 characters!');
      return;
    }

    if (password != confirmPassword) {
      showMessage('Passwords do not match!');
      return;
    }

    savedUsername = username;
    savedPassword = password;

    usernameController.clear();
    passwordController.clear();
    emailController.clear();
    confirmPasswordController.clear();

    setState(() {
      isSignup = false;
    });

    showMessage('Signup successful! Now login.', success: true);
  }

  Widget inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    Widget? suffix,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white70),
          prefixIcon: Icon(icon, color: Colors.amber),
          suffixIcon: suffix,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white38),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.amber, width: 2),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        centerTitle: true,

        foregroundColor: const Color.fromARGB(255, 8, 7, 7),
        title: const Text(
          'Pakistan Study',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/back_grounds.jpg'),
            fit: BoxFit.cover,
          ),
        ),

        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: const Color.fromARGB(255, 190, 4, 97),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(120, 190, 4, 97),
                    blurRadius: 15,
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
                    color: Colors.deepPurpleAccent,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    isSignup ? 'Create Your Account' : 'Welcome Back!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isSignup ? 'Sign Up' : 'Login To Your Account',
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.amberAccent,
                    ),
                  ),
                  const SizedBox(height: 20),

                  inputField(
                    controller: usernameController,
                    hint: 'Username',
                    icon: Icons.person,
                  ),

                  if (isSignup)
                    inputField(
                      controller: emailController,
                      hint: 'Email',
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                    ),

                  inputField(
                    controller: passwordController,
                    hint: 'Password',
                    icon: Icons.lock,
                    obscure: hidePassword,
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      icon: Icon(
                        hidePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white70,
                      ),
                    ),
                  ),

                  if (isSignup)
                    inputField(
                      controller: confirmPasswordController,
                      hint: 'Confirm Password',
                      icon: Icons.lock_outline,
                      obscure: hideConfirmPassword,
                      suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            hideConfirmPassword = !hideConfirmPassword;
                          });
                        },
                        icon: Icon(
                          hideConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white70,
                        ),
                      ),
                    ),

                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isSignup ? signup : login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 11, 3, 122),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        isSignup ? 'CREATE ACCOUNT' : 'LOGIN',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

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
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.amberAccent,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
