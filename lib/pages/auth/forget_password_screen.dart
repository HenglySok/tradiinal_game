import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradinal_game/Colors/app_colors.dart';
import 'package:tradinal_game/providers/user_provider.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();

  bool _isEmailVerified = false;
  bool _isObscure = true;

  void _handleReset() {
    final userProv = Provider.of<UserProvider>(context, listen: false);
    final String email = _emailController.text.trim();

    if (!_isEmailVerified) {
      if (userProv.checkEmailExists(email)) {
        setState(() {
          _isEmailVerified = true;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email not found! Please check and try again."),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      if (_formKey.currentState!.validate()) {
        userProv.updatePassword(email, _newPassController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password updated successfully!")),
        );
        _emailController.clear();
        _newPassController.clear();
        Navigator.pop(context);
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
            colors: [AppColors.primary, Color(0xFFD32F2F), Colors.white],
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
                        Text(
                          _isEmailVerified
                              ? "SET NEW PASSWORD"
                              : "VERIFY ACCOUNT",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _isEmailVerified
                              ? "Please enter your password below"
                              : "Enter your email address to find your account",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Email Input
                        _buildShadowedInput(
                          controller: _emailController,
                          hint: "Email or Phone number",
                          icon: Icons.email,
                          readOnly: _isEmailVerified,
                        ),

                        if (_isEmailVerified) ...[
                          const SizedBox(height: 20),
                          // New Password Input
                          _buildShadowedInput(
                            controller: _newPassController,
                            hint: "Password",
                            icon: Icons.lock,
                            isPassword: true,
                            obscureText: _isObscure,
                            onToggle: () =>
                                setState(() => _isObscure = !_isObscure),
                            validator: (val) => (val == null || val.length < 8)
                                ? "Min 8 characters required"
                                : null,
                          ),
                        ],

                        const SizedBox(height: 30),

                        // Action Button
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: _handleReset,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.altPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 5,
                            ),
                            child: Text(
                              _isEmailVerified
                                  ? "Reset Password"
                                  : "Verify account",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
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

  Widget _buildShadowedInput({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool readOnly = false,
    bool isPassword = false,
    bool? obscureText,
    VoidCallback? onToggle,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        obscureText: isPassword ? (obscureText ?? true) : false,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: Icon(icon, color: Colors.black87, size: 28),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText! ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black87,
                  ),
                  onPressed: onToggle,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey, width: 0.2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey, width: 0.2),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }
}
