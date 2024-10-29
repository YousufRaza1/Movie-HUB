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