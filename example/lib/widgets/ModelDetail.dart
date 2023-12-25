// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ModelDetail extends StatelessWidget {
  final List<Widget> actions;
  final Widget o3d;

  const ModelDetail({
    super.key,
    required this.actions,
    required this.o3d,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Wrap(
            children: actions
                .map((child) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      child: child,
                    ))
                .toList(),
          ),
          AspectRatio(aspectRatio: 1 / 2, child: o3d)
        ],
      ),
    );
  }
}
