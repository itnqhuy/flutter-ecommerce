import 'package:cloud_firestore/cloud_firestore.dart';

import '../features/shop/models/banner_model.dart';
import '../features/shop/models/category_model.dart';
import '../routes/routes.dart';
import '../utils/constants/image_strings.dart';

class DummyData {
  final List<CategoryModel> categories = [
    // -------- DANH MỤC CHA --------
    CategoryModel(
      id: '1',
      name: 'Laptop',
      imageUrl: MyImages.laptopCategory,
      parentCate: null,
      isFeatured: true,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    ),
    CategoryModel(
      id: '2',
      name: 'Monitor',
      imageUrl: MyImages.monitorCategory,
      parentCate: null,
      isFeatured: true,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    ),
    CategoryModel(
      id: '3',
      name: 'Hardware',
      imageUrl: MyImages.hardwareCategory,
      parentCate: null,
      isFeatured: true,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    ),
    CategoryModel(
      id: '4',
      name: 'Keyboard',
      imageUrl: MyImages.keyboardCategory,
      parentCate: null,
      isFeatured: true,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    ),
    CategoryModel(
      id: '5',
      name: 'Mouse',
      imageUrl: MyImages.mouseCategory,
      parentCate: null,
      isFeatured: true,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    ),
    CategoryModel(
      id: '6',
      name: 'Camera',
      imageUrl: MyImages.cameraCategory,
      parentCate: null,
      isFeatured: true,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    ),

    // -------- SUBCATEGORIES --------

    //   // Laptop
    //   CategoryModel(
    //     id: '7',
    //     name: 'Laptop cảm ứng',
    //     imageUrl: MyImages.laptopCategory,
    //     parentCate: '1',
    //     isFeatured: false,
    //     createdAt: Timestamp.now(),
    //     updatedAt: Timestamp.now(),
    //   ),
    //   CategoryModel(
    //     id: '8',
    //     name: 'Laptop không cảm ứng',
    //     imageUrl: MyImages.laptopCategory,
    //     parentCate: '1',
    //     isFeatured: false,
    //     createdAt: Timestamp.now(),
    //     updatedAt: Timestamp.now(),
    //   ),

    //   // Monitor
    //   CategoryModel(
    //     id: '9',
    //     name: 'Gaming Monitor',
    //     imageUrl: MyImages.monitorCategory,
    //     parentCate: '2',
    //     isFeatured: false,
    //     createdAt: Timestamp.now(),
    //     updatedAt: Timestamp.now(),
    //   ),
    //   CategoryModel(
    //     id: '10',
    //     name: 'Office Monitor',
    //     imageUrl: MyImages.monitorCategory,
    //     parentCate: '2',
    //     isFeatured: false,
    //     createdAt: Timestamp.now(),
    //     updatedAt: Timestamp.now(),
    //   ),

    //   // Hardware
    //   CategoryModel(
    //     id: '11',
    //     name: 'Mainboard',
    //     imageUrl: MyImages.hardwareCategory,
    //     parentCate: '3',
    //     isFeatured: false,
    //     createdAt: Timestamp.now(),
    //     updatedAt: Timestamp.now(),
    //   ),
    //   CategoryModel(
    //     id: '12',
    //     name: 'CPU',
    //     imageUrl: MyImages.hardwareCategory,
    //     parentCate: '3',
    //     isFeatured: false,
    //     createdAt: Timestamp.now(),
    //     updatedAt: Timestamp.now(),
    //   ),
    //   CategoryModel(
    //     id: '13',
    //     name: 'RAM',
    //     imageUrl: MyImages.hardwareCategory,
    //     parentCate: '3',
    //     isFeatured: false,
    //     createdAt: Timestamp.now(),
    //     updatedAt: Timestamp.now(),
    //   ),

    //   // Keyboard
    //   CategoryModel(
    //     id: '14',
    //     name: 'Cơ',
    //     imageUrl: MyImages.keyboardCategory,
    //     parentCate: '4',
    //     isFeatured: false,
    //     createdAt: Timestamp.now(),
    //     updatedAt: Timestamp.now(),
    //   ),
    //   CategoryModel(
    //     id: '15',
    //     name: 'Không cơ',
    //     imageUrl: MyImages.keyboardCategory,
    //     parentCate: '4',
    //     isFeatured: false,
    //     createdAt: Timestamp.now(),
    //     updatedAt: Timestamp.now(),
    //   ),

    //   // Mouse
    //   CategoryModel(
    //     id: '16',
    //     name: 'Có dây',
    //     imageUrl: MyImages.mouseCategory,
    //     parentCate: '5',
    //     isFeatured: false,
    //     createdAt: Timestamp.now(),
    //     updatedAt: Timestamp.now(),
    //   ),
    //   CategoryModel(
    //     id: '17',
    //     name: 'Không dây',
    //     imageUrl: MyImages.mouseCategory,
    //     parentCate: '5',
    //     isFeatured: false,
    //     createdAt: Timestamp.now(),
    //     updatedAt: Timestamp.now(),
    //   ),

    //   // Camera
    //   CategoryModel(
    //     id: '18',
    //     name: 'Webcam',
    //     imageUrl: MyImages.cameraCategory,
    //     parentCate: '6',
    //     isFeatured: false,
    //     createdAt: Timestamp.now(),
    //     updatedAt: Timestamp.now(),
    //   ),
  ];

  /// -- Banners
  final List<BannerModel> banners = [
    BannerModel(
        imageUrl:
            "https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/H1_1440x242_45e65222b1.png",
        targetScreen: MyRoutes.order,
        active: true),
    BannerModel(
        imageUrl:
            "https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/H1_1440x242_3d6491adf3.png",
        targetScreen: MyRoutes.cart,
        active: true),
    BannerModel(
        imageUrl:
            "https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/H1_1440x242_42b816baef.png",
        targetScreen: MyRoutes.favourites,
        active: false),
    BannerModel(
        imageUrl:
            "https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/H1_1440x242_42b816baef.png",
        targetScreen: MyRoutes.search,
        active: false),
    BannerModel(
        imageUrl:
            "https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/H1_1440x242_42b816baef.png",
        targetScreen: MyRoutes.settings,
        active: false),
    BannerModel(
        imageUrl:
            "https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/H1_1440x242_42b816baef.png",
        targetScreen: MyRoutes.userAddress,
        active: false),
    BannerModel(
        imageUrl:
            "https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/H1_1440x242_42b816baef.png",
        targetScreen: MyRoutes.checkout,
        active: false),
  ];
}
