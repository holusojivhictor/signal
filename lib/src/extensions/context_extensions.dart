import 'package:flutter/widgets.dart';
import 'package:signal/src/utils/utils.dart';

extension BuildContextExtensions on BuildContext {
  void development() {
    final fToast = ToastUtils.of(this);
    ToastUtils.showInfoToast(fToast, 'In development');
  }
}
