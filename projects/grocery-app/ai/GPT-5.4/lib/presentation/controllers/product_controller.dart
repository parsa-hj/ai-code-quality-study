import 'package:get/get.dart';

import '../../data/models/product_model.dart';

class ProductController extends GetxController {
  final selectedVariant = ''.obs;
  final quantity = 1.obs;
  final selectedImage = ''.obs;

  void setup(ProductModel product) {
    if (selectedVariant.value.isEmpty) {
      selectedVariant.value = product.variants.first;
      selectedImage.value = product.gallery.first;
      quantity.value = 1;
    }
  }

  void chooseVariant(String variant) {
    selectedVariant.value = variant;
  }

  void chooseImage(String image) {
    selectedImage.value = image;
  }

  void increment() {
    quantity.value++;
  }

  void decrement() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }
}
