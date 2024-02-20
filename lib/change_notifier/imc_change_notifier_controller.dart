import 'dart:math';

import 'package:flutter/material.dart';

class ImcChangeNotifierController extends ChangeNotifier {
  var imc = 0.0;

  Future<void> calcImc(
      {required double weigth, required double stature}) async {
    imc = 0;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    imc = weigth / pow(stature, 2);
    notifyListeners();
  }
}
