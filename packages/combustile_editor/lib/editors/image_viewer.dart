import 'dart:typed_data';

import 'package:combustile_editor/platform_tools/platform_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageView extends StatefulWidget {
  const ImageView({
    super.key,
    required this.image,
  });

  final String image;

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  late Future<Uint8List> _imageBytes;

  @override
  void initState() {
    super.initState();

    final fileManager = context.read<FileManager>();
    _imageBytes = fileManager.loadFileBytes(widget.image);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _imageBytes,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return Padding(
            padding: const EdgeInsets.all(32),
            child: Image.memory(
              snapshot.data!,
              filterQuality: FilterQuality.none,
              fit: BoxFit.contain,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
