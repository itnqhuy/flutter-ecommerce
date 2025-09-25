import 'package:get/get.dart';
import '../../../data/repositories/categories/categories_repository.dart';
import '../../../data/repositories/products/product_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  /// Observables
  final isLoading = false.obs;
  final RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  final RxList<ProductModel> categoryProducts = <ProductModel>[].obs;
  final RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  /// Repository
  final CategoryRepository _categoryRepository = Get.put(CategoryRepository());
  final ProductRepository _productRepository = Get.put(ProductRepository());

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategoryProducts(String categoryId, {int limit = 6}) async {
    try {
      final products =
          await _productRepository.getProductsByCategory(categoryId, limit);
      categoryProducts.assignAll(products); // Lưu vào danh sách observable
    } catch (e) {
      MyLoaders.errorSnackBar(title: "Lỗi!", message: e.toString());
    }
  }

  /// Fetch all categories and filter featured ones
  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;

      // Get all categories
      final categories = await _categoryRepository.getAllCategories();
      allCategories.assignAll(categories);

      // Filter featured top-level categories
      final featured = categories
          .where(
              (category) => category.isFeatured && category.parentCate == null)
          .take(6)
          .toList();

      featuredCategories.assignAll(featured);
    } catch (e) {
      MyLoaders.errorSnackBar(
        title: 'Oops!',
        message: 'Không thể tải danh mục: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Load selected category data
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final subCategories =
          await _categoryRepository.getSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      MyLoaders.errorSnackBar(
        title: 'Oops!!',
        message: e.toString(),
      );
      return [];
    }
  }

  /// Get Category or Sub-Category Products
  Future<List<ProductModel>> getCategoryProducts({
    required String categoryId,
    int limit = 4,
  }) async {
    try {
      final products =
          await _productRepository.getProductsByCategory(categoryId, limit);
      return products;
    } catch (e) {
      MyLoaders.errorSnackBar(
        title: 'Lỗi!',
        message: e.toString(),
      );
      return [];
    }
  }
}
