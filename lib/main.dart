import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'data/dummy_data.dart';
import 'data/repositories/authentication/authentication_repository.dart';
import 'data/services/firebase_storage_service.dart';
import 'firebase_options.dart';
import 'app.dart';

Future<void> main() async {
  // Todo: Add Widgets Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // Todo: Init Local Storage
  await GetStorage.init();
  // Todo: Init Payment Methods

  // Todo: Await Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Todo: Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then(
    (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );

  uploadDummyData();
  // Todo: Initialize Authentication
  runApp(const App());
}

void uploadDummyData() async {
  Get.put(MyFirebaseStorageService());

  // final storageService = MyFirebaseStorageService.instance;

  // Upload categories
  // await storageService.uploadDummyData(DummyData().categories);

  // Upload banners
  // await storageService.uploadDummyBanners(DummyData().banners);
}
