import 'package:flutter/material.dart';
import 'package:state_management_bmi_calculator/widgets/imc_gauge_range.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ImcGauge extends StatelessWidget {
  final double imc;

  const ImcGauge({super.key, required this.imc});
  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: [
        RadialAxis(
          showAxisLine: false,
          showLabels: false,
          showTicks: false,
          minimum: 12.5,
          maximum: 47.9,
          ranges: [
            ImcGaugeRange(
                color: Colors.blue, start: 12.5, end: 18.5, label: "MAGREZA"),
            ImcGaugeRange(
                color: Colors.green, start: 18.6, end: 24.9, label: "NORMAL"),
            ImcGaugeRange(
                color: Colors.yellow[600]!,
                start: 25.0,
                end: 29.9,
                label: "SOBREPESO"),
            ImcGaugeRange(
                color: Colors.orange,
                start: 30.0,
                end: 34.9,
                label: "OBESIDADE I"),
            ImcGaugeRange(
                color: Colors.red[500]!,
                start: 35.0,
                end: 39.9,
                label: "OBESIDADE II"),
            ImcGaugeRange(
                color: Colors.red[900]!,
                start: 40.0,
                end: 47.9,
                label: "OBESIDADE III")
          ],
          pointers: [
            NeedlePointer(
              enableAnimation: true,
              value: imc,
            )
          ],
        )
      ],
    );
  }
}
