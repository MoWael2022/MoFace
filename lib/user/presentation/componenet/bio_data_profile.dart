import 'package:flutter/material.dart';

import '../../../core/constant.dart';

class BioDataProfile extends StatelessWidget {
  final String name;
  final String email;
  final int numberOfFriends;
  final int numberOfPosts;
  final String id;

  const BioDataProfile({
    super.key,
    required this.name,
    required this.email,
    required this.numberOfFriends,
    required this.numberOfPosts,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Constant.width(context) * .3, // Adjusted width
      padding: const EdgeInsets.all(16), // Padding inside the container
      decoration: BoxDecoration(
        color: Colors.grey[100], // Light grey background color
        borderRadius: BorderRadius.circular(16), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2), // Shadow position
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Email: $email",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoCard("Friends", numberOfFriends.toString(), Colors.blue),
              _infoCard("Posts", numberOfPosts.toString(), Colors.green),
            ],
          ),
          const SizedBox(height: 16),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       "User ID: $id",
          //       style: const TextStyle(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w500,
          //         color: Colors.black45,
          //       ),
          //     ),
          //     ElevatedButton(
          //       onPressed: () {
          //         // Add action for editing profile or navigating
          //       },
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: Colors.blueAccent, // Button color
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(12), // Rounded button
          //         ),
          //       ),
          //       child: const Text('Edit Profile'),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget _infoCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1), // Light color background
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
