import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewComponent extends StatelessWidget {
  const ImageViewComponent({super.key, required this.url});

  final String url;
  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: url.contains('http')
          ? NetworkImage(url)
          : url.contains('assets')
              ? AssetImage(url)
              : FileImage(File(url)),
    );
  }
}
