import 'package:get/get.dart';
import '../../../../data/repositories/products/product_repository.dart';
import '../../../../data/repositories/ratings/rating_repository.dart';
import '../../models/product_model.dart';
import '../../models/sku_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final RxList<ProductModel> allProducts = <ProductModel>[].obs;
  final RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  final RxList<ProductModel> brandProducts = <ProductModel>[].obs;
  final RxList<ProductModel> categoryProducts = <ProductModel>[].obs;
  final RxList<ProductModel> displayedProducts = <ProductModel>[].obs;
  final RxMap<String, SkuModel> skuCache = <String, SkuModel>{}.obs;

  final ProductRepository _productRepository = Get.put(ProductRepository());

  @override
  void onInit() {
    fetchAllProducts();
    fetchFeaturedProducts();
    super.onInit();
  }

  Future<void> fetchFeaturedProducts() async {
    try {
      isLoading.value = true;
      final products = await _productRepository.getFeaturedProducts();
      featuredProducts.assignAll(products);
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thể tải sản phẩm nổi bật: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchProductsByBrand(String brandId) async {
    try {
      isLoading.value = true;
      final products = await _productRepository.getProductsByBrand(brandId);
      brandProducts.assignAll(products);
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thể tải sản phẩm theo thương hiệu: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchProductsByCategory(String categoryId) async {
    try {
      isLoading.value = true;
      final products =
          await _productRepository.getProductsByCategory(categoryId);
      categoryProducts.assignAll(products);
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thể tải sản phẩm theo danh mục: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAllProducts() async {
    try {
      isLoading.value = true;
      final products = await _productRepository.getAllPublishedProducts();
      allProducts.assignAll(products);
      displayedProducts.assignAll(products);
      for (var p in products) {
        await loadProductRatings(p.id);
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thể tải sản phẩm: $e');
    } finally {
      isLoading.value = false;
    }
  }

  final RxMap<String, double> productRatingCache = <String, double>{}.obs;
  final RxMap<String, int> productRatingCountCache = <String, int>{}.obs;

  Future<void> loadProductRatings(String productId) async {
    final ratings = await RatingRepository.getRatingsByProductId(productId);
    if (ratings.isEmpty) {
      productRatingCache[productId] = 0.0;
      productRatingCountCache[productId] = 0;
      return;
    }

    final total = ratings.fold<int>(0, (sum, r) => sum + r.star);
    final average = total / ratings.length;

    productRatingCache[productId] = average;
    productRatingCountCache[productId] = ratings.length;
  }

  String getProductPriceRange(List<SkuModel> skus) {
    if (skus.isEmpty) return '0';

    int minPrice = skus.first.price;
    int maxPrice = skus.first.price;

    for (final sku in skus) {
      if (sku.price < minPrice) minPrice = sku.price;
      if (sku.price > maxPrice) maxPrice = sku.price;
    }

    if (minPrice == maxPrice) {
      return minPrice.toString();
    } else {
      return '$minPrice - $maxPrice';
    }
  }

  void sortByPrice({bool descending = false}) {
    final sorted = [...displayedProducts];
    sorted.sort((a, b) {
      final priceA = skuCache[a.id]?.price ?? 0;
      final priceB = skuCache[b.id]?.price ?? 0;
      return descending ? priceB.compareTo(priceA) : priceA.compareTo(priceB);
    });
    displayedProducts.assignAll(sorted);
  }

  void sortByName() {
    final sorted = [...displayedProducts];
    sorted.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    displayedProducts.assignAll(sorted);
  }

  void sortByRating({bool descending = false}) {
    final sorted = [...displayedProducts];
    sorted.sort((a, b) {
      final ratingA = productRatingCache[a.id] ?? 0.0;
      final ratingB = productRatingCache[b.id] ?? 0.0;
      return descending
          ? ratingB.compareTo(ratingA)
          : ratingA.compareTo(ratingB);
    });
    displayedProducts.assignAll(sorted);
  }

  void searchProducts(String query) {
    final results = allProducts.where((p) {
      return p.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    displayedProducts.assignAll(results);
  }
}
