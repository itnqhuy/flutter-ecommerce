import 'package:flutter/material.dart';

class MyCloudHelperFunction {
  static Widget? checkMultiRecorState<T>(
      {required AsyncSnapshot<List<T>> snapshot,
      Widget? loader,
      Widget? error,
      Widget? nothingFound}) {
    if (snapshot.connectionState == ConnectionState.waiting) {
<<<<<<< HEAD
      return loader;
=======
      return loader ?? const Center(child: CircularProgressIndicator());
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
    }

    if (snapshot.hasError) {
      return const Center(child: Text('Đã có lỗi xảy ra'));
    }

<<<<<<< HEAD
    if (!snapshot.hasData || snapshot.data!.isEmpty) {
=======
    if (!snapshot.hasData) {
>>>>>>> 6565bfa7f21905c3680d4c666f5911bfd5eac5d1
      return const Center(child: Text('Không tìm thấy dữ liệu'));
    }
    return null;
  }
}
