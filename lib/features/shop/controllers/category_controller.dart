import 'package:get/get.dart';
import '../../../data/repositories/categories/categories_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../models/category_model.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  /// Observables
  final isLoading = false.obs;
  final RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  final RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  /// Repository
  final CategoryRepository _categoryRepository = Get.put(CategoryRepository());

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
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
              (category) => category.isFeatured && category.parentCate.isEmpty)
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
}
