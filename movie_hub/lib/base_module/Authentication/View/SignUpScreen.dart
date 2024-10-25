import 'package:flutter/material.dart';
import 'forget_password_screen.dart';
import '../ViewModel/AuthViewModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'reset_password_dialog.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  final AuthViewModel = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String userEmail = "";
  String password = "";
  bool _obscureText = true; // Manage the visibility state

  void _onChanged(String value) {
    userEmail = value;
    print("Current value: $value");
  }

  void _onChanged1(String value) {
    password = value;
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
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
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
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    'Sign Up',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer()
                ],
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                children: [
                  Text(
                    'Email address',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                  Spacer()
                ],
              ),
              SizedBox(height: 6),
              Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey, width: 1)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Center(
                      child: Material(
                          child: TextField(
                        controller: _controller,
                        // TextEditingController to manage text input
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          // Background color of the TextField
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            // Rounded corners
                            borderSide: BorderSide.none, // Remove border
                          ),
                          labelText: userEmail,

                          hintText: 'Enter email here',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          // Placeholder text
                          suffixIcon: Icon(
                            Icons.check_circle,
                            // Suffix icon (right side)
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                        onChanged: (text) {
                          _onChanged(text); // Print text when changed
                        },
                      )),
                    ),
                  )),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Password',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                  Spacer()
                ],
              ),
              SizedBox(height: 5),
              Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey, width: 1)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Center(
                      child: Material(
                          child: TextField(
                        controller: _controller2,
                        // TextEditingController to manage text input
                        obscureText: _obscureText,

                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          // Background color of the TextField
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            // Rounded corners
                            borderSide: BorderSide.none, // Remove border
                          ),
                          labelText: password,
                          // Label for the text field
                          hintText: 'Enter your password here',
                          // Placeholder text
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 30,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              // Toggle the state
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                        onChanged: (text) {
                          _onChanged1(text); // Print text when changed
                        },
                      )),
                    ),
                  )),
              SizedBox(height: 0),
              SizedBox(height: 25),
              Container(
                width: double.infinity, // Infinite width
                height: 56, // Fixed height
                child: ElevatedButton(
                  onPressed: () async {
                    print('sign up pressed');

                    await AuthViewModel.createUserWithEmailAndPassword(
                        userEmail, password, context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: Divider()),
                  SizedBox(width: 10),
                  Text(
                    'Email address',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(width: 10),
                  Expanded(child: Divider())
                ],
              ),
              SizedBox(height: 25),
              SocialMediaLoginSection(media: medias),
              SizedBox(height: 25),
              Row(
                children: [
                  Spacer(),
                  Text(
                    'Email address',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('log in')),
                  Spacer()
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}

class Socialmedia {
  String name;
  String imageUrl;

  Socialmedia({required this.name, required this.imageUrl});
}

class SocialMediaLoginSection extends StatefulWidget {
  final List<Socialmedia> media;

  const SocialMediaLoginSection({super.key, required this.media});

  @override
  State<SocialMediaLoginSection> createState() =>
      _SocialMediaLoginSectionState();
}

class _SocialMediaLoginSectionState extends State<SocialMediaLoginSection> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10, // Horizontal space between columns
            mainAxisSpacing: 10),
        itemCount: widget.media.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              print('tap on $index');
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: Colors.grey.withOpacity(0.5), width: 1)
                  // Circular border radius
                  ),
              child: Image.network(widget.media[index].imageUrl),
            ),
          );
        });
  }
}
