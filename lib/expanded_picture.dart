import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'image_model.dart';

class ExpandedPicture extends StatelessWidget {
  final PixabayImage image;
  const ExpandedPicture({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// The Pixabay API gives the previewURL and the image can be a bit blurry.
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(image.user),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Container(
            child: Image.network(
              image.previewURL,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ));
  }
}
