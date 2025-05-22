import 'package:get/get.dart';
import '../../../../data/repositories/SKUs/sku_repository.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/sku_model.dart';

class SkuController extends GetxController {
  static SkuController get instance => Get.find();

  final RxMap<String, SkuModel> skuCache = <String, SkuModel>{}.obs;
  final RxList<SkuModel> skuList = <SkuModel>[].obs;
  final isLoading = false.obs;

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
}
