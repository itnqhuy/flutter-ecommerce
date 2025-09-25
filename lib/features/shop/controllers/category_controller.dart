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
<<<<<<< HEAD
=======
  final RxList<ProductModel> categoryProducts = <ProductModel>[].obs;
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
  final RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  /// Repository
  final CategoryRepository _categoryRepository = Get.put(CategoryRepository());
<<<<<<< HEAD
=======
  final ProductRepository _productRepository = Get.put(ProductRepository());
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

<<<<<<< HEAD
=======
  Future<void> fetchCategoryProducts(String categoryId, {int limit = 6}) async {
    try {
      final products =
          await _productRepository.getProductsByCategory(categoryId, limit);
      categoryProducts.assignAll(products); // Lưu vào danh sách observable
    } catch (e) {
      MyLoaders.errorSnackBar(title: "Lỗi!", message: e.toString());
    }
  }

>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
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
<<<<<<< HEAD
              (category) => category.isFeatured && category.parentCate.isEmpty)
=======
              (category) => category.isFeatured && category.parentCate == null)
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
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

<<<<<<< HEAD
  /// Load selected category data
=======
  /// Load subcategories by categoryId
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
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

<<<<<<< HEAD
  /// Get Category or Sub-Category Products
=======
  /// Get products by categoryId
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
  Future<List<ProductModel>> getCategoryProducts({
    required String categoryId,
    int limit = 4,
  }) async {
<<<<<<< HEAD
    final products = await ProductRepository.instance
        .getProductsByCategory(categoryId, limit);
    return products;
=======
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
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
  }
}
