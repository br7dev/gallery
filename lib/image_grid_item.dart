import 'package:flutter/material.dart';
import 'image_model.dart';

class ImageGridItem extends StatelessWidget {
  final PixabayImage image;

  const ImageGridItem({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image.network(
            image.previewURL,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.thumb_up_alt_rounded,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text('${image.likes}'),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.remove_red_eye,
                      size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text('${image.views}'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
