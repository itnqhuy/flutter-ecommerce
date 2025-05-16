import 'package:get/get.dart';
import '../../../data/repositories/brands/brand_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../models/brand_model.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  final isLoading = false.obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;

  final BrandRepository _brandRepository = Get.put(BrandRepository());

  @override
  void onInit() {
    fetchBrands();
    super.onInit();
  }

  Future<void> fetchBrands() async {
    try {
      isLoading.value = true;

      final brands = await _brandRepository.getAllBrands();
      allBrands.assignAll(brands);

      final featured = brands.where((b) => b.isFeatured).take(6).toList();
      featuredBrands.assignAll(featured);
    } catch (e) {
      MyLoaders.errorSnackBar(
        title: 'Oops!',
        message: 'Không thể tải thương hiệu: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<BrandModel> getBrandById(String id) async {
    try {
      return await _brandRepository.getBrandById(id);
    } catch (e) {
      MyLoaders.errorSnackBar(
        title: 'Lỗi',
        message: 'Không tìm thấy thương hiệu',
      );
      return BrandModel.empty();
    }
  }

  final RxMap<String, BrandModel> brandCache = <String, BrandModel>{}.obs;

  Future<void> loadBrandById(String id) async {
    if (id.isEmpty || brandCache.containsKey(id)) return;

    try {
      final brand = await BrandRepository.instance.getBrandById(id);
      brandCache[id] = brand;
    } catch (e) {
      throw Exception('Không tìm thấy brand: $e');
    }
  }
}
