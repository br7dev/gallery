// gallery_controller.dart
import 'package:get/get.dart';
import 'package:image_gallery/api_key.dart';
import 'image_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class GalleryController extends GetxController {
  static const int perPage = 20;

  var images = <PixabayImage>[].obs;
  var isLoading = false.obs;
  var page = 1;
  var hasMore = true.obs;

  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void onInit() {
    super.onInit();
    fetchImages();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          !isLoading.value &&
          hasMore.value) {
        fetchImages();
      }
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    searchController.dispose();
    super.onClose();
  }

  void onSearch() {
    searchQuery = searchController.text.trim();
    page = 1;
    images.clear();
    hasMore.value = true;
    fetchImages();
  }

  Future<void> fetchImages() async {
    if (isLoading.value || !hasMore.value) return;
    isLoading.value = true;

    String url =
        'https://pixabay.com/api/?key=${ApiKeys.pixabayApiKey}&image_type=photo&per_page=$perPage&page=$page';
    if (searchQuery.isNotEmpty) {
      url += '&q=${Uri.encodeQueryComponent(searchQuery)}';
    }

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        PixabayResponse pixabayResponse =
            PixabayResponse.fromJson(json.decode(response.body));

        if (pixabayResponse.hits.isNotEmpty) {
          images.addAll(pixabayResponse.hits);
          page++;
          if (pixabayResponse.hits.length < perPage) {
            hasMore.value = false;
          }
        } else {
          hasMore.value = false;
        }
      } else {
        hasMore.value = false;
      }
    } catch (e) {
      hasMore.value = false;
      Get.snackbar('Error', 'Failed to load images');
    } finally {
      isLoading.value = false;
    }
  }
}
