import 'package:flutter/material.dart';

class MyCloudHelperFunction {
  static Widget? checkMultiRecorState<T>(
      {required AsyncSnapshot<List<T>> snapshot,
      Widget? loader,
      Widget? error,
      Widget? nothingFound}) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return loader;
    }

    if (snapshot.hasError) {
      return const Center(child: Text('Đã có lỗi xảy ra'));
    }

    if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return const Center(child: Text('Không tìm thấy dữ liệu'));
    }
    return null;
  }
}
