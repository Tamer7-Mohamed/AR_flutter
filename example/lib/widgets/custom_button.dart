// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';

class CustomButon extends StatelessWidget {
  CustomButon({
    super.key,
    this.onTap,
    required this.text,
  });
  VoidCallback? onTap;
  String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onTap,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
            Theme.of(context).colorScheme.onBackground,
          )),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
