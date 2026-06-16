import 'package:flutter/material.dart';
import 'package:expanse_tracker_app/screens/auth/register_screen.dart';
import '../../services/auth_service.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  final AuthService authService = AuthService();

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (emailController.text.trim().isEmpty ||
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

      final user = await authService.loginUser(
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
            content: Text("Login Successful"),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
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
            e.toString().replaceFirst('Exception: ', ''),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                        CircleAvatar(radius: 40,backgroundColor: Color(0xFF0014A8),
                          child: Icon(Icons.account_balance_wallet,
                            size: 50,color: Color(0xFFF8FAFC)),
                        ),
                    SizedBox(height: 10,),
                    const Text(
                      "Expense Tracker",
                      style: TextStyle(
                        color: Color(0xFF0014A8),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10,),
                    const Text("Manage your expenses smartly",style: TextStyle(
                      color: Colors.black
                    ),),

                    const SizedBox(height: 30),

                    TextField(
                      controller: emailController,
                      decoration:  InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.35),
                        prefixIcon: Icon(Icons.email,color: Color(0xFF0014A8),),
                        hintText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),

                        ),
                      ),

                    ),

                    const SizedBox(height: 15),

                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration:  InputDecoration(
                        prefixIcon: Icon(Icons.lock,color: Color(0xFF0014A8),),
                        hintText: "Password",
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.35),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),

                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: Color(0xFF0014A8)
                      ),
                        onPressed: isLoading ? null : login,
                        child: isLoading
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : const Text("Login",style: TextStyle(color: Color(0xFFF8FAFC),fontWeight: FontWeight.bold),),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const RegisterScreen(),
                              ),
                            );
                          },
                          child: const Text("Register",style: TextStyle(color: Color(0xFF0014A8),fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),
                  ],
            ),
          ),
        ),
      ),

    );
  }
}