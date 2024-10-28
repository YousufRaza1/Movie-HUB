import 'package:flutter/material.dart';
import 'forget_password_screen.dart';
import '../ViewModel/AuthViewModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'reset_password_dialog.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _auth = Get.find();

  void _onEmailChanged(String value) {
    _auth.userEmail.value = value;
    print("Current value: $value");
  }

  void _onPasswordChanged(String value) {
    _auth.password.value = value;
    print("Current value: $value");
  }

  final List<Socialmedia> medias = [
    Socialmedia(
        name: 'Google',
        imageUrl:
        'https://cdn.dribbble.com/users/904380/screenshots/2230701/google-logo-revised-spinner_still_2x.gif?resize=400x300&vertical=center'),
    Socialmedia(
        name: 'Twitter',
        imageUrl:
        'https://cdn.mos.cms.futurecdn.net/z3bn6deaxmrjmQHNEkpcZE-1200-80.jpg'),
    Socialmedia(
        name: 'Facebook',
        imageUrl:
        'https://static.vecteezy.com/system/resources/previews/018/930/476/original/facebook-logo-facebook-icon-transparent-free-png.png')
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    final borderColor = isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300;
    final theme = Theme.of(context);

    return Obx(() => Container(
      color: backgroundColor,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
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
                Row(
                  children: [
                    Text(
                      'Sign up',
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    Spacer()
                  ],
                ),
                SizedBox(height: 35),
                _buildLabel('Email address', textColor),
                SizedBox(height: 6),
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
                          controller: _emailController,
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
                            _auth.isValidEmail(text);

                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                _buildLabel('Password', textColor),
                SizedBox(height: 5),

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
                          controller: _passwordController,
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
                            _auth.isValidPassword(text);
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 25),
                _buildSignUpButton(),
                SizedBox(height: 25),
                _buildDivider(textColor),
                SizedBox(height: 25),
                SocialMediaLoginSection(media: medias),
                SizedBox(height: 25),
                _buildLoginRow(context, textColor),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget _buildLabel(String text, Color textColor) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Text(
          text,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.normal,
            color: theme.colorScheme.onSurface,
          ),
        ),
        Spacer()
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required ValueChanged<String> onChanged,
    bool obscureText = false,
    required Color borderColor,
    Widget? suffixIcon,
  }) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Material(
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            onChanged: onChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).cardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              labelText: labelText,
              hintText: hintText,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: ((_auth.isLoading == true) || _auth.isValidForPassword.value == false || _auth.isValidForEmail == false) ? null : () async {
          await _auth.createUserWithEmailAndPassword(_auth.userEmail.value, _auth.password.value, context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:(_auth.isValidForPassword.value == true && _auth.isValidForEmail == true) ? theme.colorScheme.primary: theme.colorScheme.primary.withOpacity(0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          _auth.isLoading == true ? 'Loading' : 'Sign up',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildDivider(Color textColor) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(child: Divider(color: textColor)),
        SizedBox(width: 10),
        Text(
          'or continue with',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.normal,
            color: theme.colorScheme.onSurface,
          ),
        ),
        SizedBox(width: 10),
        Expanded(child: Divider(color: textColor)),
      ],
    );
  }

  Widget _buildLoginRow(BuildContext context, Color textColor) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Spacer(),
        Text(
          'Already have an account',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.normal,
            color: theme.colorScheme.onSurface,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'login',
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.normal,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}

class Socialmedia {
  String name;
  String imageUrl;

  Socialmedia({required this.name, required this.imageUrl});
}

class SocialMediaLoginSection extends StatelessWidget {
  final List<Socialmedia> media;

   SocialMediaLoginSection({super.key, required this.media});
  final authViewModel = AuthService();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: media.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {

            print('tap on ${media[index].name}');
            authViewModel.signInWithGoogle(context);

          },
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
            ),
            child: Image.network(media[index].imageUrl),
          ),
        );
      },
    );
  }
}
