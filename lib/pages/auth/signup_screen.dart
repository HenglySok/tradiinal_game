import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradinal_game/Colors/app_colors.dart';
import 'package:tradinal_game/providers/user_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  // Handles the logic for creating a new account
  void _handleSignUp() {
    final userProv = Provider.of<UserProvider>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text.trim();

      if (userProv.checkEmailExists(email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Account already exists with this email"),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        userProv.registerUser(
          _nameController.text.trim(),
          email,
          _passController.text,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Account created successfully!")),
        );

        Navigator.pop(context); // Go back to Login
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const SizedBox(height: 60),
            const Text(
              "ល្បែងប្រជាប្រិយខ្មែរ",
              style: TextStyle(
                color: AppColors.gold,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: Colors.black45, blurRadius: 2)],
              ),
            ),
            const SizedBox(height: 30),
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
                        const Text(
                          "Create Your\nAccount",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 25),

                        // Full Name Field
                        _buildInputField(
                          controller: _nameController,
                          hint: "Full Name",
                          icon: Icons.person,
                          validator: (val) => (val == null || val.isEmpty)
                              ? "Please enter your name"
                              : null,
                        ),

                        // Email Field with Gmail/Yahoo Validation
                        _buildInputField(
                          controller: _emailController,
                          hint: "Email or Phone number",
                          icon: Icons.email,
                          validator: (val) {
                            if (val == null || val.isEmpty)
                              return "Enter email/phone";

                            // Regex for standard email format
                            final emailRegex = RegExp(
                              r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                            );
                            if (!emailRegex.hasMatch(val)) {
                              return "Invalid format (e.g., user@gmail.com)";
                            }
                            return null;
                          },
                        ),

                        // Password Field
                        _buildInputField(
                          controller: _passController,
                          hint: "Password",
                          icon: Icons.lock,
                          isPassword: true,
                          obscureText: _obscurePassword,
                          onToggleVisibility: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                          validator: (val) => (val == null || val.length < 8)
                              ? "Min 8 characters required"
                              : null,
                        ),

                        // Confirm Password Field
                        _buildInputField(
                          controller: _confirmPassController,
                          hint:
                              "Confirm Passwrod", // Matched typo from your design image
                          icon: Icons.cached,
                          isPassword: true,
                          obscureText: _obscureConfirm,
                          onToggleVisibility: () => setState(
                            () => _obscureConfirm = !_obscureConfirm,
                          ),
                          validator: (val) => (val != _passController.text)
                              ? "Passwords do not match"
                              : null,
                        ),

                        const SizedBox(height: 20),

                        // Sign Up Button
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: _handleSignUp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.altPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 5,
                            ),
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                        const Center(
                          child: Text(
                            "- or sign up with -",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Google Account Button
                        _buildGoogleButton(),

                        const SizedBox(height: 30),

                        // Footer Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "You have an Account? ",
                              style: TextStyle(color: Colors.grey),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Text(
                                "Sign In ",
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

  // Shadowed Input Field Helper
  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required String? Function(String?)? validator,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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
        obscureText: isPassword ? obscureText : false,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.black87, size: 28),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onPressed: onToggleVisibility,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey, width: 0.5),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }

  // Google Social Button Helper
  Widget _buildGoogleButton() {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1200px-Google_%22G%22_logo.svg.png',
            height: 28,
          ),
          const SizedBox(width: 15),
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
}
