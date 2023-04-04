import 'package:flutter/material.dart';
import 'package:nes_ui/nes_ui.dart';

class ProjectTree extends StatelessWidget {
  const ProjectTree({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return NesContainer(
      width: width,
      height: double.infinity,
      child: const Center(
        child: Text('Project Tree'),
      ),
    );
  }
}
