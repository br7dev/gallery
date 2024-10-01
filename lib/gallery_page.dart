// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery/image_grid_item.dart';
import 'package:image_gallery/image_model.dart';
import 'gallery_controller.dart';

class GalleryPage extends StatelessWidget {
  final GalleryController controller = Get.put(GalleryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Pixabay Gallery'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Search Bar and Search Button
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Material(
                    elevation: 4.0,
                    shadowColor: Colors.black45,
                    borderRadius: BorderRadius.circular(8.0),
                    child: SizedBox(
                      height: 44,
                      child: TextField(
                        controller: controller.searchController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: 'Search images...',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          prefixIcon:
                              Icon(Icons.search, color: Colors.grey[600]),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear, color: Colors.grey[600]),
                            onPressed: () {
                              if (controller.searchController.text.isNotEmpty) {
                                controller.searchController.clear();
                                controller.onSearch();
                              }
                            },
                          ),
                        ),
                        onSubmitted: (value) {
                          controller.onSearch();
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.onSearch();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                      // Text and icon color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 4.0,
                      // padding:
                      //     EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    ),
                    child: Text(
                      'Search',
                      style: TextStyle(fontSize: 16.0, color: Colors.black87),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // The Image Gallery Section
          Expanded(
            child: Obx(() {
              if (controller.images.isEmpty && controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (controller.images.isEmpty) {
                return Center(child: Text('No images found'));
              } else {
                double screenWidth = MediaQuery.of(context).size.width;
                int crossAxisCount = (screenWidth ~/ 150).clamp(2, 4);

                return GridView.builder(
                  controller: controller.scrollController,
                  padding: EdgeInsets.all(4),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    // childAspectRatio: 0.7,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                  ),
                  itemCount: controller.images.length + 1,
                  itemBuilder: (context, index) {
                    if (index == controller.images.length) {
                      return controller.hasMore.value
                          ? const Center(child: CircularProgressIndicator())
                          : SizedBox.shrink();
                    }
                    var image = controller.images[index];
                    return ImageGridItem(image: image);
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
