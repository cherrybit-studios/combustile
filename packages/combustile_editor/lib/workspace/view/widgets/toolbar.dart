import 'package:combustile_editor/l10n/l10n.dart';
import 'package:flutter/material.dart';

/// {@template toolbar}
/// A widget that displays a toolbar.
/// {@endtemplate}
class Toolbar extends StatelessWidget {
  /// {@macro toolbar}
  const Toolbar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Center(
      // TODO(erickzanardo): Add an icon here isntead?.
      child: Text(l10n.combustile),
    );
  }
}
