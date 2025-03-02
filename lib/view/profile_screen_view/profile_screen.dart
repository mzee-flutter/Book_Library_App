import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SmallBookCard(),
    );
  }
}

class SmallBookCard extends StatelessWidget {
  const SmallBookCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none, // Ensures no clipping
        alignment: Alignment.topCenter,
        children: [
          // Base Container
          Container(
            width: 120,
            height: 160,
          ),
          // D-Shaped Container (Rounded side upwards, bottom-aligned)
          Positioned(
            bottom: 0,
            child: Container(
              width: 120,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.cyan.withOpacity(0.3),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(100),
                  topRight: Radius.circular(100),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
            ),
          ),

          Positioned(
            top: 15, // Slightly above
            child: Container(
              width: 80,
              height: 130,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
