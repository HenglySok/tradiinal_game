import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradinal_game/Colors/app_colors.dart';
import 'package:tradinal_game/main_wrapper.dart';
import 'package:tradinal_game/providers/user_provider.dart';
import 'package:tradinal_game/pages/auth/signup_screen.dart';
import 'package:tradinal_game/pages/auth/forget_password_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Background Gradient to match the image
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primary, Color(0xffD32F2F), Colors.white],
            stops: [0.0, 0.3, 0.6],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 70),
            const Text(
              "ល្បែងប្រជាប្រិយខ្មែរ",
              style: TextStyle(
                color: AppColors.gold,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: Colors.black45, blurRadius: 2)],
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "Login to your account",
                          style: TextStyle(fontSize: 22, color: Colors.black54),
                        ),
                        const SizedBox(height: 30),

                        // Email Field with Shadow
                        _buildStyledInput(
                          controller: _emailController,
                          hint: "Email or Phone number",
                          icon: Icons.email_outlined,
                        ),
                        const SizedBox(height: 20),

                        // Password Field with Shadow & Toggle
                        _buildStyledInput(
                          controller: _passwordController,
                          hint: "Password",
                          icon: Icons.lock_outline,
                          isPassword: true,
                        ),

                        // Sign In Button
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.altPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 5,
                            ),
                            child: const Text(
                              "Sign in",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        // Forgot Password Link
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ForgetPasswordScreen(),
                              ),
                            ),
                            child: const Text(
                              "forget password?",
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                          ),
                        ),

                        // Social Divider
                        const Center(
                          child: Text(
                            "- or sign in with -",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Google Account Button
                        _buildSocialButton(),

                        const SizedBox(height: 100),

                        // Footer
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an Account? ",
                              style: TextStyle(color: Colors.grey),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupScreen(),
                                ),
                              ),
                              child: const Text(
                                "Sign Up ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Text(
                              "now",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helper for Shadowed Input Fields
  Widget _buildStyledInput({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ? _isObscure : false,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.black87, size: 30),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onPressed: () => setState(() => _isObscure = !_isObscure),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey, width: 0.5),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
        ),
      ),
    );
  }

  // Google Social Button
  Widget _buildSocialButton() {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black45),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1200px-Google_%22G%22_logo.svg.png',
            height: 30,
          ),
          const SizedBox(width: 20),
          const Text(
            "GOOGLE ACCOUNT",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  void _handleLogin() {
    final userProv = Provider.of<UserProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      bool isValid = userProv.validateLogin(
        _emailController.text.trim(),
        _passwordController.text,
      );
      if (isValid) {
        _emailController.clear();
        _passwordController.clear();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainWrapper()),
        );
      } else {
        _emailController.clear();
        _passwordController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid Credentials"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
