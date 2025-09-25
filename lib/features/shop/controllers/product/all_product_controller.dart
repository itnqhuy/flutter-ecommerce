import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/products/product_repository.dart';
import '../../models/product_model.dart';

class AllProductController extends GetxController {
  static AllProductController get instance => Get.find();

  final repository = ProductRepository.instance;

  Future<List<ProductModel>> fetchProductByQuery(Query? query) async {
    try {
      if (query == null) return [];
      final products = await repository.fetchProductsByQuery(query);
      return products;
    } catch (e) {
      MyLoaders.errorSnackBar(title: 'Oops!!', message: e.toString());
      return [];
    }
  }
}
