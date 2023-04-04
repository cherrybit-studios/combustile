import 'package:flutter/material.dart';
import 'package:nes_ui/nes_ui.dart';

class Editors extends StatelessWidget {
  const Editors({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const NesContainer(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Text('Editors'),
      ),
    );
  }
}
