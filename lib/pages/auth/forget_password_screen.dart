import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  // Logic state
  bool _isEmailVerified = false;
  bool _isObscure = true;

  void _handleReset() {
    final userProv = Provider.of<UserProvider>(context, listen: false);
    final String email = _emailController.text.trim();

    if (!_isEmailVerified) {
      // Step 1: Verify if account exists
      if (userProv.checkEmailExists(email)) {
        setState(() {
          _isEmailVerified = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email found! Please enter your new password."),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email not found! Please check and try again."),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // Step 2: Update the password in Provider
      if (_formKey.currentState!.validate()) {
        userProv.updatePassword(email, _newPassController.text);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password updated successfully!")),
        );

        Navigator.pop(context); // Return to Login Screen
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff800000), // Match your theme
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const Text(
            "Forgot Password",
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isEmailVerified
                            ? "Set New Password"
                            : "Verify Account",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff800000),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _isEmailVerified
                            ? "Please enter your new password below."
                            : "Enter your email address to find your account.",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 30),

                      // Email Input Field
                      TextFormField(
                        controller: _emailController,
                        readOnly: _isEmailVerified, // Lock email once verified
                        decoration: InputDecoration(
                          hintText: "Email Address",
                          prefixIcon: const Icon(Icons.email_outlined),
                          filled: true,
                          fillColor: _isEmailVerified
                              ? Colors.grey[200]
                              : Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      if (_isEmailVerified) ...[
                        const SizedBox(height: 20),
                        // New Password Input Field
                        TextFormField(
                          controller: _newPassController,
                          obscureText: _isObscure,
                          decoration: InputDecoration(
                            hintText: "New Password",
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () =>
                                  setState(() => _isObscure = !_isObscure),
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (val) => (val == null || val.length < 8)
                              ? "Password must be at least 8 characters"
                              : null,
                        ),
                      ],

                      const SizedBox(height: 40),

                      // Action Button
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: _handleReset,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff800000),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            _isEmailVerified
                                ? "Reset Password"
                                : "Verify Email",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
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
        ],
      ),
    );
  }
}
