import 'dart:async';
import 'dart:math';

import 'package:state_management_bmi_calculator/bloc_pattern/imc_bloc_pattern_state.dart';

class ImcBlocPatternController {
  final _imcStreamController = StreamController<ImcBlocPatternState>()
    ..add(ImcBlocPatternState(imc: 0.0));

  Stream<ImcBlocPatternState> get imcOut => _imcStreamController.stream;

  Future<void> calcImc(
      {required double weight, required double stature}) async {
    _imcStreamController.add(ImcBlocPatternState(imc: 0.0));
    await Future.delayed(const Duration(seconds: 1));
    final imc = weight / pow(stature, 2);
    _imcStreamController.add(ImcBlocPatternState(imc: imc));
  }

  void dispose() {
    _imcStreamController.close();
  }
}
