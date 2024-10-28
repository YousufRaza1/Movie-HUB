import 'package:flutter/material.dart';
import '../ViewModel/AuthViewModel.dart';

class SocialMediaLoginSection extends StatelessWidget {
  final authViewModel = AuthService();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        authViewModel.signInWithGoogle(context);
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(
                color: theme.colorScheme.outlineVariant,
                width: 1.0
            )

        ),
        child: Center(
          child: Row(
            children: [
              // Spacer(),
              // // Image.network('https://cdn.dribbble.com/users/904380/screenshots/2230701/google-logo-revised-spinner_still_2x.gif?resize=400x300&vertical=center',height: 40,width: 40),
              Spacer(),
              Text(
                'Continue with Google',
                style: theme.textTheme.bodyLarge
                    ?.copyWith(color: theme.colorScheme.onBackground),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}