import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  // Simulando un usuario para esta vista
  final User user = User(
    name: "ian",
    email: "ufro@example.com",
    imagePath: "assets/profile.png",
    about: "I like movies.",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          buildProfileImage(),
          const SizedBox(height: 24),
          buildName(),
          const SizedBox(height: 24),
          buildAbout(),
        ],
      ),
    );
  }

  Widget buildProfileImage() => Center(
    child: CircleAvatar(
      radius: 48,
      backgroundImage: AssetImage(user.imagePath),
    ),
  );

  Widget buildName() => Column(
    children: [
      Text(
        user.name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        user.email,
        style: const TextStyle(color: Colors.grey),
      ),
    ],
  );

  Widget buildAbout() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          user.about,
          style: const TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );
}

class User {
  final String name;
  final String email;
  final String imagePath;
  final String about;

  User({
    required this.name,
    required this.email,
    required this.imagePath,
    required this.about,
  });
}
