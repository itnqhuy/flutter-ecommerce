import 'package:ecommerce/utils/formatters/fomatter.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/SKUs/sku_repository.dart';
import '../../../../data/repositories/products/product_repository.dart';
import '../../../../data/repositories/promotions/promotion_repository.dart';
import '../../../../data/repositories/ratings/rating_repository.dart';
import '../../models/product_model.dart';
import '../../models/rating_model.dart';
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

  // Cache điểm trung bình rating và tổng số rating
  final RxMap<String, double> productRatingCache = <String, double>{}.obs;
  final RxMap<String, int> productRatingCountCache = <String, int>{}.obs;

  // Cache phân bố rating theo từng sao
  final RxMap<String, Map<int, int>> productRatingCountByStarsCache =
      <String, Map<int, int>>{}.obs;

  final RxMap<String, String> productPriceRangeCache = <String, String>{}.obs;

  final ProductRepository _productRepository = Get.put(ProductRepository());

  @override
  void onInit() {
    fetchAllProducts();
    fetchFeaturedProducts();
    super.onInit();
  }

  Future<void> fetchAllProducts() async {
    try {
      isLoading.value = true;
      final products = await _productRepository.getAllPublishedProducts();
      allProducts.assignAll(products);
      displayedProducts.assignAll(products);

      for (var p in products) {
        await Future.wait([
          loadDefaultSkuByProductId(p.id),
          loadProductRatings(p.id),
          loadPriceRange(p.id),
          _loadLowestPriceSku(p.id),
        ]);
      }
    } catch (e) {
      MyLoaders.errorSnackBar(title: 'Lỗi', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      final products = await _productRepository.getFeaturedProducts();
      featuredProducts.assignAll(products);
      return products;
    } catch (e) {
      MyLoaders.errorSnackBar(title: 'Lỗi', message: e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> fetchAllProductsForHome() async {
    try {
      final products = await _productRepository.getAllPublishedProducts();
      return products;
    } catch (e) {
      MyLoaders.errorSnackBar(title: 'Lỗi', message: e.toString());
      return [];
    }
  }

  Future<void> fetchFeaturedProducts() async {
    try {
      isLoading.value = true;
      final products = await _productRepository.getFeaturedProducts();
      featuredProducts.assignAll(products);
    } catch (e) {
      MyLoaders.errorSnackBar(title: 'Lỗi', message: e.toString());
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
      MyLoaders.errorSnackBar(title: 'Lỗi', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  final RxList<SkuModel> skuList = <SkuModel>[].obs;
  Future<List<ProductModel>> fetchProductsByCategory(String categoryId) async {
    try {
      isLoading.value = true;
      final products =
          await _productRepository.getFeatureProductsByCategory(categoryId);
      categoryProducts.assignAll(products);
      return products;
    } catch (e) {
      MyLoaders.errorSnackBar(title: 'Lỗi', message: e.toString());
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadDefaultSkuByProductId(String productId) async {
    if (!skuCache.containsKey(productId)) {
      final sku = await SkuRepository.getDefaultSkuByProductId(productId);
      if (sku != null) {
        skuCache[productId] = sku;
      }
    }
  }

  Future<List<SkuModel>> loadAllSkusByProductId(String productId) async {
    try {
      isLoading.value = true;
      if (skuList.isNotEmpty &&
          skuList.any((sku) => sku.productId.id == productId)) {
        return skuList.where((sku) => sku.productId.id == productId).toList();
      }

      final skus = await SkuRepository.getAllSkusByProductId(productId);

      skuList.clear();
      skuList.addAll(skus);

      return skus;
    } catch (e) {
      MyLoaders.errorSnackBar(
          title: 'Oops!', message: 'Không thể tải đánh giá: ${e.toString()}');
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  /// Tải rating cho sản phẩm, cập nhật cache rating trung bình, tổng rating và phân bố sao
  Future<void> loadProductRatings(String productId) async {
    final ratings = await RatingRepository.getRatingsByProductId(productId);

    if (ratings.isEmpty) {
      productRatingCache[productId] = 0.0;
      productRatingCountCache[productId] = 0;
      productRatingCountByStarsCache[productId] = {
        1: 0,
        2: 0,
        3: 0,
        4: 0,
        5: 0
      };
      return;
    }

    // Tính điểm trung bình
    final totalStars = ratings.fold<int>(0, (sum, r) => sum + r.star);
    final average = totalStars / ratings.length;
    productRatingCache[productId] = average;
    productRatingCountCache[productId] = ratings.length;

    // Thống kê số lượng rating theo sao
    final Map<int, int> countMap = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    for (var r in ratings) {
      countMap[r.star] = (countMap[r.star] ?? 0) + 1;
    }
    productRatingCountByStarsCache[productId] = countMap;
  }

  /// Lấy điểm trung bình rating của sản phẩm theo productId
  double getAverageRating(String productId) {
    return productRatingCache[productId] ?? 0.0;
  }

  /// Lấy tổng số rating
  int getRatingCount(String productId) {
    return productRatingCountCache[productId] ?? 0;
  }

  /// Lấy phân bố rating theo số sao
  Map<int, int> getRatingCountByStars(String productId) {
    return productRatingCountByStarsCache[productId] ??
        {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
  }

  Future<void> loadPriceRange(String productId) async {
    try {
      final skus = await SkuRepository.getAllSkusByProductId(productId);
      productPriceRangeCache[productId] = _computePriceRangeFromSkus(skus);
    } catch (e) {
      productPriceRangeCache[productId] = '₫0';
    }
  }

  String _computePriceRangeFromSkus(List<SkuModel> skus) {
    final validSkus = skus.where((sku) => sku.price > 0).toList();
    if (validSkus.isEmpty) return '₫0';

    int minPrice = validSkus.first.price;
    int maxPrice = validSkus.first.price;

    for (final sku in validSkus) {
      if (sku.price < minPrice) minPrice = sku.price;
      if (sku.price > maxPrice) maxPrice = sku.price;
    }

    if (minPrice == maxPrice) {
      return MyFormatter.formatCurrency(minPrice);
    } else {
      return '${MyFormatter.formatDecimalOnly(minPrice)} - ${MyFormatter.formatDecimalOnly(maxPrice)}₫';
    }
  }

  String getPriceRangeByProductId(String productId) {
    return productPriceRangeCache[productId] ?? '...';
  }

  final RxMap<String, SkuModel> lowestPriceSkuCache = <String, SkuModel>{}.obs;
  final RxMap<String, int> lowestPriceSkuFinalPriceCache = <String, int>{}.obs;

  Future<void> _loadLowestPriceSku(String productId) async {
    final skus = await SkuRepository.getAllSkusByProductId(productId);
    if (skus.isEmpty) return;

    skus.sort((a, b) => a.price.compareTo(b.price));
    final lowestSku = skus.first;
    lowestPriceSkuCache[productId] = lowestSku;

    // Lấy promotion mới nhất cho SKU thấp nhất
    final promotion = await PromotionRepository.getLatestBySkuId(lowestSku.id);
    if (promotion != null && promotion.end.toDate().isAfter(DateTime.now())) {
      final discount =
          ((lowestSku.price * promotion.discountPercent) / 100).round();
      lowestPriceSkuFinalPriceCache[productId] = lowestSku.price - discount;
    } else {
      lowestPriceSkuFinalPriceCache[productId] = lowestSku.price;
    }
  }

  int getLowestPriceWithPromotion(String productId) {
    return lowestPriceSkuFinalPriceCache[productId] ?? 0;
  }

  int getLowestPriceWithPromotionPercent(String productId) {
    final sku = lowestPriceSkuCache[productId];
    if (sku == null) return 0;

    final finalPrice = getLowestPriceWithPromotion(productId);
    if (finalPrice >= sku.price || sku.price == 0) return 0;

    final discountPercent =
        ((sku.price - finalPrice) * 100 / sku.price).round();
    return discountPercent;
  }

  final RxList<ProductModel> sortableProducts = <ProductModel>[].obs;
  final RxString selectedSortOption = 'Tên'.obs;

  void loadProducts(List<ProductModel> products) {
    sortableProducts.assignAll(products);
    sortProducts('Tên');
  }

  void sortProducts(String sortOption) {
    selectedSortOption.value = sortOption;
    switch (sortOption) {
      case 'Tên':
        sortByName();
        break;
      case 'Giá giảm dần':
        sortByPrice(descending: true);
        break;
      case 'Giá tăng dần':
        sortByPrice(descending: false);
        break;
      case 'Đánh giá':
        sortByRating(descending: true);
        break;
      default:
        sortByName();
        break;
    }
  }

  void sortByPrice({bool descending = false}) {
    final sorted = [...sortableProducts];
    sorted.sort((a, b) {
      final priceA = skuCache[a.id]?.price ?? 0;
      final priceB = skuCache[b.id]?.price ?? 0;
      return descending ? priceB.compareTo(priceA) : priceA.compareTo(priceB);
    });
    sortableProducts.assignAll(sorted);
    sortableProducts.refresh();
  }

  void sortByName() {
    final sorted = [...sortableProducts];
    sorted.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    sortableProducts.assignAll(sorted);
    sortableProducts.refresh();
  }

  void search(String query, List<ProductModel> sourceList) {
    if (query.isEmpty) {
      sortableProducts.assignAll(sourceList);
    } else {
      final filtered = sourceList
          .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      sortableProducts.assignAll(filtered);
      sortableProducts.refresh();
    }
  }

  void sortByRating({bool descending = false}) {
    final sorted = [...sortableProducts];
    sorted.sort((a, b) {
      final ratingA = productRatingCache[a.id] ?? 0.0;
      final ratingB = productRatingCache[b.id] ?? 0.0;
      return descending
          ? ratingB.compareTo(ratingA)
          : ratingA.compareTo(ratingB);
    });
    sortableProducts.assignAll(sorted);
    sortableProducts.refresh();
  }

  Future<List<RatingModel>> getRatingsByProduct(String productId) async {
    return await ProductRepository.instance.getRatingsByProduct(productId);
  }
}
