import 'package:flutter/material.dart';
import 'SignUpScreen.dart';
import '../ViewModel/AuthViewModel.dart';
import 'reset_password_dialog.dart';
import 'package:get/get.dart';
import '../../buttom_navigation_screen.dart';
import 'social_media_login.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  final AuthService _authViewModel = Get.find();
  bool _obscureText = true;


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Obx(() => Container(
          color: theme.scaffoldBackgroundColor,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Header and Logo
                    Row(
                      children: [
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 27, top: 45),
                          child: Image.asset(
                            'assets/star 8.png',
                            color: textColor,
                          ),
                        )
                      ],
                    ),
                    // Login title
                    Row(
                      children: [
                        Text(
                          'Log in',
                          style: theme.textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                    SizedBox(height: 35),
                    // Email address label
                    Row(
                      children: [
                        Text(
                          'Email address',
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: theme.colorScheme.onSurface),
                        ),
                        Spacer()
                      ],
                    ),
                    SizedBox(height: 6),
                    // Email input field
                    Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: theme.colorScheme.outline,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Center(
                          child: Material(
                            child: TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: theme.colorScheme.surface,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Enter email here',
                                hintStyle: TextStyle(
                                  color: theme.hintColor,
                                ),
                                suffixIcon: Icon(
                                  Icons.check_circle,
                                  color: theme.iconTheme.color,
                                ),
                              ),
                              onChanged: (text) {
                                _authViewModel.isValidEmail(text);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Password label
                    Row(
                      children: [
                        Text(
                          'Password',
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: theme.colorScheme.onSurface),
                        ),
                        Spacer()
                      ],
                    ),
                    SizedBox(height: 6),
                    // Password input field
                    Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: theme.colorScheme.outline,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Center(
                          child: Material(
                            child: TextField(
                              controller: _controller2,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: theme.colorScheme.surface,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Enter your password here',
                                hintStyle: TextStyle(color: theme.hintColor),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: theme.iconTheme.color,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                              ),
                              onChanged: (text) {
                                print(text);

                                _authViewModel.isValidPassword(text);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    // Forgot password link
                    Row(
                      children: [
                        TextButton(
                          onPressed: () async {
                            _authViewModel.isValidEmail(_controller.text);
                            _authViewModel.isValidPassword(_controller2.text);
                            Get.to(BottomNavScreen());
                          },
                          child: Text(
                            'Skip now',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            displayTextInputDialog(context);
                          },
                          child: Text(
                            'Forgot password',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 0),
                    // Sign in button
                    Container(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _authViewModel.isLoading == true ||
                                _authViewModel.isValidForEmail == false ||
                                _authViewModel.isValidForPassword == false
                            ? null
                            : () async {
                                await _authViewModel.signInWithEmailAndPassword(
                                    _authViewModel.userEmail.value,
                                    _authViewModel.password.value,
                                    context);
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              (_authViewModel.isValidForPassword.value ==
                                          true &&
                                      _authViewModel.isValidForEmail == true)
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.primary.withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(
                          _authViewModel.isLoading == true
                              ? 'Loading'
                              : 'Sign in',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 12),
                    // Divider with text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(child: Divider(color: theme.dividerColor)),
                        SizedBox(width: 10),
                        Text(
                          'Or Continue with',
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(color: theme.colorScheme.onBackground),
                        ),
                        SizedBox(width: 10),
                        Expanded(child: Divider(color: theme.dividerColor)),
                      ],
                    ),
                    SizedBox(height: 25),
                    // Social media login section
                    SocialMediaLoginSection(),
                    SizedBox(height: 25),
                    // Sign up section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: theme.colorScheme.onSurface),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()),
                            );
                          },
                          child: Text('Sign up'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}



