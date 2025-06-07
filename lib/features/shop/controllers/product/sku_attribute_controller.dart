import 'package:get/get.dart';
import '../../../../data/repositories/SKUs/sku_repository.dart';
import '../../../../data/repositories/product_attributes/product_attribute_repository.dart';
import '../../../../data/repositories/promotions/promotion_repository.dart';
import '../../../../data/repositories/sku_attributes/sku_attribute_repository.dart';
import '../../models/product_attribute_model.dart';
import '../../models/promotion_model.dart';
import '../../models/sku_attribute_model.dart';
import '../../models/sku_model.dart';

class SkuAttributeController extends GetxController {
  static SkuAttributeController get instance => Get.find();

  final _allSkus = <SkuModel>[].obs;
  final _allSkuAttrs = <SkuAttributeModel>[].obs;
  final _allProductAttrs = <ProductAttributeModel>[].obs;
  final currentPromotion = Rxn<PromotionModel>();

  final isInitialized = false.obs;
  final selectedAttributes = <String, String>{}.obs;
  final selectedSku = Rxn<SkuModel>();
  final stockStatus = ''.obs;
  final originalPrice = RxInt(0);
  final finalPrice = RxInt(0);

  final _skuAttrMap = <String, Map<String, String>>{}.obs;

  Future<void> fetchAndPrepare(String productId) async {
    try {
      isInitialized.value = false;
      _resetData();

      final skuList = await SkuRepository.getAllSkusByProductId(productId);
      final attrList =
          await ProductAttributeRepository.getByProductId(productId);
      final skuAttrList = await SkuAttributeRepository.getBySkus(
        skuList.map((e) => e.id).toList(),
      );

      if (skuList.isEmpty) {
        Get.snackbar('Lỗi dữ liệu', 'Không tìm thấy SKU cho sản phẩm này.');
        _resetData();
        return;
      }

      if (attrList.isEmpty) {
        Get.snackbar(
            'Lỗi dữ liệu', 'Không tìm thấy thuộc tính cho sản phẩm này.');
        _resetData();
        return;
      }

      if (skuAttrList.isEmpty) {
        Get.snackbar('Lỗi dữ liệu', 'Không tìm thấy phân loại cho SKU.');
        _resetData();
        return;
      }

      _initialize(skus: skuList, attrs: attrList, skuAttrs: skuAttrList);
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thể tải dữ liệu: $e');
      _resetData();
    } finally {
      isInitialized.value = true;
    }
  }

  void _initialize({
    required List<SkuModel> skus,
    required List<ProductAttributeModel> attrs,
    required List<SkuAttributeModel> skuAttrs,
  }) {
    _allSkus.assignAll(skus);
    _allSkuAttrs.assignAll(skuAttrs);
    _allProductAttrs.assignAll(attrs);

    _skuAttrMap.clear();

    for (final skuAttr in _allSkuAttrs) {
      final skuId = skuAttr.skuId.id;
      final attrId = skuAttr.attributeId.id;
      final attrName = _getAttrNameById(attrId);

      if (attrName == null) continue;

      _skuAttrMap.putIfAbsent(skuId, () => {});
      _skuAttrMap[skuId]![attrName] = skuAttr.value;
    }
  }

  String? _getAttrNameById(String attrId) {
    final attr = _allProductAttrs.firstWhereOrNull((e) => e.id == attrId);
    return attr?.name;
  }

  Future<void> onAttributeSelected(String attr, String value) async {
    if (value.isEmpty) {
      selectedAttributes.remove(attr);

      if (selectedAttributes.isEmpty) {
        selectedSku.value = null;
        stockStatus.value = '';
        originalPrice.value = 0;
        finalPrice.value = 0;
        currentPromotion.value = null;
        return;
      }
    } else {
      selectedAttributes[attr] = value;
    }

    for (final entry in _skuAttrMap.entries) {
      if (_matchesSelected(entry.value, selectedAttributes)) {
        final sku = _allSkus.firstWhere(
          (s) => s.id == entry.key,
          orElse: () => SkuModel.empty(),
        );

        selectedSku.value = sku;
        stockStatus.value = sku.stock > 0 ? 'Còn hàng' : 'Hết hàng';
        originalPrice.value = sku.price;

        final promotion = await PromotionRepository.getLatestBySkuId(sku.id);
        currentPromotion.value = promotion;

        if (promotion != null &&
            promotion.end.toDate().isAfter(DateTime.now())) {
          final discount =
              ((sku.price * promotion.discountPercent) / 100).round();
          finalPrice.value = sku.price - discount;
        } else {
          currentPromotion.value = null;
          finalPrice.value = sku.price;
        }

        return;
      }
    }

    selectedSku.value = null;
    stockStatus.value = 'Không có phân loại này';
    originalPrice.value = 0;
    finalPrice.value = 0;
    currentPromotion.value = null;
  }

  bool get hasDiscountApplied =>
      selectedSku.value != null &&
      finalPrice.value > 0 &&
      finalPrice.value < originalPrice.value;

  Future<bool> isSelectionComplete() async {
    final requiredAttrCount = await SkuAttributeRepository.countAttributesOfSku(
        selectedSku.value!.id);
    return selectedAttributes.length == requiredAttrCount &&
        !selectedAttributes.values.any((v) => v.isEmpty);
  }

  bool _matchesSelected(
      Map<String, String> skuAttrs, Map<String, String> selected,
      {bool exactMatch = false}) {
    if (exactMatch && selected.length != skuAttrs.length) return false;

    for (final key in selected.keys) {
      if (skuAttrs[key] != selected[key]) return false;
    }

    return true;
  }

  Set<String> getAvailableValues(String attrName) {
    final values = <String>{};

    for (final entry in _skuAttrMap.entries) {
      final sku = _allSkus.firstWhereOrNull((s) => s.id == entry.key);
      if (sku == null || sku.stock <= 0) continue;

      final value = entry.value[attrName];
      if (value != null && value.isNotEmpty) values.add(value);
    }

    return values;
  }

  Set<String> getUnavailableValues(String attrName) {
    final unavailable = <String>{};
    final selected = Map<String, String>.from(selectedAttributes);

    final allValues = _allSkuAttrs
        .where((e) => _getAttrNameById(e.attributeId.id) == attrName)
        .map((e) => e.value)
        .toSet();

    for (final value in allValues) {
      selected[attrName] = value;

      final found = _skuAttrMap.entries.any((entry) {
        final sku = _allSkus.firstWhereOrNull((s) => s.id == entry.key);
        if (sku == null || sku.stock <= 0) return false;

        return _matchesSelected(entry.value, selected, exactMatch: false);
      });

      if (!found) unavailable.add(value);
    }

    return unavailable;
  }

  List<ProductAttributeModel> get allProductAttrs => _allProductAttrs;

  void _resetData() {
    _allSkus.clear();
    _allProductAttrs.clear();
    _allSkuAttrs.clear();
    _skuAttrMap.clear();
    selectedAttributes.clear();
    selectedSku.value = null;
    stockStatus.value = '';
    originalPrice.value = 0;
    finalPrice.value = 0;
  }
}
