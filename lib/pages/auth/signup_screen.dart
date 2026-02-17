import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradinal_game/providers/user_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers to capture user input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  void _handleSignUp() {
    final userProv = Provider.of<UserProvider>(context, listen: false);

    // 1. Validate form fields
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text.trim();
      final String email = _emailController.text.trim();
      final String password = _passController.text;

      // 2. Logic: Check if Gmail already exists
      if (userProv.checkEmailExists(email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email នេះមានរួចហើយ! (Email already exists)"),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        // 3. Logic: Save to Provider and Navigate
        userProv.registerUser(name, email, password);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("បង្កើតគណនីជោគជ័យ! (Account Created)")),
        );

        Navigator.pop(context); // Go back to Login
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff800000), // Dark Red Header
      body: SingleChildScrollView(
        child: Column(
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

            Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Create Your\nAccount",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff800000),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Name Field
                    _buildInputField(
                      controller: _nameController,
                      hint: "Full Name",
                      icon: Icons.person_outline,
                      validator: (val) => (val == null || val.isEmpty)
                          ? "Enter your name"
                          : null,
                    ),

                    // Gmail Validation
                    _buildInputField(
                      controller: _emailController,
                      hint: "Email (Must be @gmail.com)",
                      icon: Icons.email_outlined,
                      validator: (val) {
                        if (val == null || !val.endsWith("@gmail.com")) {
                          return "Use a valid @gmail.com address";
                        }
                        return null;
                      },
                    ),

                    // Password Length Validation (Min 8)
                    _buildInputField(
                      controller: _passController,
                      hint: "Password",
                      icon: Icons.lock_outline,
                      isPassword: true,
                      validator: (val) => (val == null || val.length < 8)
                          ? "Min 8 characters required"
                          : null,
                    ),

                    // Confirm Password Logic
                    _buildInputField(
                      controller: _confirmPassController,
                      hint: "Confirm Password",
                      icon: Icons.lock_reset_outlined,
                      isPassword: true,
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
                          backgroundColor: const Color(0xffA53232),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Sign up",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required String? Function(String?)? validator,
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.grey),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
        validator: validator,
      ),
    );
  }
}
