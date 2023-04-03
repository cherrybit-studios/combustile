import 'package:combustile_editor/l10n/l10n.dart';
import 'package:flutter/material.dart';

class WorkspaceView extends StatelessWidget {
  const WorkspaceView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: Center(
        child: Text(l10n.combustile),
      ),
    );
  }
}
