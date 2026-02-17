import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradinal_game/main_wrapper.dart';
import 'package:tradinal_game/providers/user_provider.dart';
import 'package:tradinal_game/pages/auth/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;

  void _handleLogin() {
    final userProv = Provider.of<UserProvider>(context, listen: false);
    final String email = _emailController.text.trim();
    final String password = _passwordController.text;

    if (_formKey.currentState!.validate()) {
      bool isValid = userProv.validateLogin(email, password);

      if (isValid) {
        _emailController.clear();
        _passwordController.clear();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainWrapper()),
        );

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("ចូលប្រើប្រាស់ជោគជ័យ!")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("អ៊ីមែល ឬលេខសម្ងាត់មិនត្រឹមត្រូវ!"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Reusable border style for symmetry
    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.grey),
    );

    return Scaffold(
      backgroundColor: const Color(0xff800000),
      body: Column(
        children: [
          const SizedBox(height: 60),
          const Text(
            "ល្បែងប្រជាប្រិយខ្មែរ",
            style: TextStyle(
              color: Color(0xffFFD700),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        "Login to your account",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      const SizedBox(height: 30),

                      // Email Field with OutlineBox
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: "Email or Phone number",
                          prefixIcon: const Icon(Icons.email_outlined),
                          enabledBorder: outlineBorder,
                          focusedBorder: outlineBorder.copyWith(
                            borderSide: const BorderSide(
                              color: Color(0xff800000),
                              width: 2,
                            ),
                          ),
                          errorBorder: outlineBorder.copyWith(
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: outlineBorder.copyWith(
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your email";
                          }
                          final emailRegex = RegExp(
                            r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          );
                          if (!emailRegex.hasMatch(value.trim())) {
                            return "Invalid email format (missing @ or .)";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),

                      // Password Field with Toggle & OutlineBox
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () =>
                                setState(() => _isObscure = !_isObscure),
                          ),
                          enabledBorder: outlineBorder,
                          focusedBorder: outlineBorder.copyWith(
                            borderSide: const BorderSide(
                              color: Color(0xff800000),
                              width: 2,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.length < 8) {
                            return "Password must be >= 8 characters";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),

                      // Sign In Button
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff800000),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Sign in",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.blue,
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
          ),
        ],
      ),
    );
  }
}
