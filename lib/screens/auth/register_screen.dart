import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {
  bool isLoading = false;

  final AuthService authService = AuthService();

  final TextEditingController nameController =
  TextEditingController();

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final user = await authService.registerUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registration Successful"),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString().replaceFirst(
              'Exception: ',
              '',
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0014A8), // Zaffre Blue

      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 25,
                top: 40,
                right: 25,
                bottom: 30,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Create An\nAccount",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 35),

                      TextField(
                        controller: nameController,
                        decoration:  InputDecoration(
                            prefixIcon: Icon(Icons.person,color: Color(0xFF0014A8),),
                            hintText: "Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)
                            )
                        ),
                      ),

                      const SizedBox(height: 25),

                      TextField(
                        controller: emailController,
                        decoration:  InputDecoration(
                            prefixIcon: Icon(Icons.email,color: Color(0xFF0014A8),),
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)
                            )
                        ),
                      ),

                      const SizedBox(height: 25),

                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration:  InputDecoration(
                          prefixIcon: Icon(Icons.lock,color: Color(0xFF0014A8),),
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)
                          ),
                        ),
                      ),

                      const SizedBox(height: 50),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF0014A8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                            ),
                        ),
                          onPressed:
                          isLoading ? null : register,
                          child: isLoading
                              ? const SizedBox(
                            height: 20,
                            width: 20,
                            child:
                            CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                              : const Text(
                            "Create Account",style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text("Already a User?"),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Color(0xFF0014A8),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}