// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:example/screens/RobotExpressive.dart';
import 'package:example/screens/camera_screen.dart';
import 'package:example/screens/camera_zombie.dart';
import 'package:example/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButon(
              text: 'zombie',
              onTap: (() => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CameraZombie()),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButon(
              text: 'RobotExpressive',
              onTap: (() => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RobotExpressive()),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButon(
              text: 'fox',
              onTap: (() => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CameraScreen()),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
