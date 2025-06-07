import 'dart:convert';

import 'package:ecommerce/data/repositories/products/product_repository.dart';
import 'package:ecommerce/utils/local_storage/storage_utility.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:get/get.dart';
import '../../models/product_model.dart';

class FavoriteController extends GetxController {
  static FavoriteController get instance => Get.find();

  final favorites = <String, bool>{}.obs;
  final RxList<ProductModel> favoriteProductList = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    initFavorites();
  }

  /// Cập nhật danh sách sản phẩm yêu thích mỗi khi favorites thay đổi
  Future<void> loadFavoriteProducts() async {
    final ids =
        favorites.entries.where((e) => e.value).map((e) => e.key).toList();
    if (ids.isEmpty) {
      favoriteProductList.clear();
    } else {
      final products =
          await ProductRepository.instance.getFavoriteProducts(ids);
      favoriteProductList.assignAll(products);
    }
  }

  /// Toggle và reload UI
  void toggleFavoriteProduct(String productId) {
    if (favorites.containsKey(productId)) {
      favorites[productId] = !favorites[productId]!;
    } else {
      favorites[productId] = true;
    }

    favorites.refresh();
    saveFavoritesToStorage();
    loadFavoriteProducts();

    MyLoaders.successSnackBar(
      title: favorites[productId]!
          ? 'Sản phẩm đã được thêm vào wishlist'
          : 'Sản phẩm đã được xóa khỏi wishlist',
      duration: 1,
    );
  }

  /// Initialize favorites from local storage
  Future<void> initFavorites() async {
    final json = MyLocalStorage.instance().readData('favorites');
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      // Only assign products that are marked as favorites (true)
      favorites.assignAll(
          storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  /// Check if a product is marked as a favorite
  bool isFavorite(String productId) {
    return favorites[productId] ?? false;
  }

// In the saveFavoritesToStorage() method, ensure you only save true favorites
  void saveFavoritesToStorage() {
    // Filter out only the products that are actually favorites (value is true)
    final filteredFavorites = Map<String, bool>.fromEntries(
      favorites.entries
          .where((entry) => entry.value), // Only keep true favorites
    );

    final encodedFavorites = json.encode(filteredFavorites); // Encode the map
    MyLocalStorage.instance()
        .saveData('favorites', encodedFavorites); // Save to storage
  }

  /// Fetch the list of favorite products from the repository
  Future<List<ProductModel>> favoriteProducts() async {
    List<String> favoriteIds = favorites.keys.toList();
    if (favoriteIds.isEmpty) {
      return []; // Return an empty list if no favorites
    }
    return await ProductRepository.instance.getFavoriteProducts(favoriteIds);
  }
}
