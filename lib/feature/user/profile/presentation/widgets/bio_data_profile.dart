import 'package:flutter/material.dart';

import '../../../../../core/utilts/api_constant.dart';
import 'info_cards.dart';


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
              InfoCards(
                  title: "Friends",
                  value: numberOfFriends.toString(),
                  color: Colors.blue),
              InfoCards(
                  title: "Posts",
                  value: numberOfPosts.toString(),
                  color: Colors.green),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
