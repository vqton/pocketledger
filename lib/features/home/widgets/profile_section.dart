import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileSection extends StatelessWidget {
  final GoogleSignInAccount user;

  ProfileSection({required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.photoUrl ?? ''),
            radius: 30,
          ),
          SizedBox(width: 10),
          Text('Hello, ${user.displayName}!', style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
