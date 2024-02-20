import 'dart:math';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:state_management_bmi_calculator/widgets/imc_gauge.dart';

class ImcValueNotifierPage extends StatefulWidget {
  const ImcValueNotifierPage({super.key});

  @override
  State<ImcValueNotifierPage> createState() => _ImcValueNotifierPageState();
}

class _ImcValueNotifierPageState extends State<ImcValueNotifierPage> {
  final formKey = GlobalKey<FormState>();
  final weightEC = TextEditingController();
  final statureEc = TextEditingController();
  var imc = ValueNotifier(0.0);
  Future<void> _calcImc(
      {required double weigth, required double stature}) async {
    imc.value = 0.0;
    await Future.delayed(const Duration(seconds: 1));

    imc.value = weigth / pow(stature, 2);
  }

  @override
  void dispose() {
    weightEC.dispose();
    statureEc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ValueNotifier'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                ValueListenableBuilder<double>(
                  valueListenable: imc,
                  builder: (_, imcValue, __) {
                    return ImcGauge(imc: imcValue);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: weightEC,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: "Peso", border: OutlineInputBorder()),
                        inputFormatters: [
                          CurrencyTextInputFormatter(
                            turnOffGrouping: true,
                            locale: "pt_BR",
                            symbol: "",
                            decimalDigits: 2,
                          )
                        ],
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Peso obrigatorio";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: statureEc,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: "Altura", border: OutlineInputBorder()),
                        inputFormatters: [
                          CurrencyTextInputFormatter(
                            turnOffGrouping: true,
                            locale: "pt_BR",
                            symbol: "",
                            decimalDigits: 2,
                          )
                        ],
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Altura obrigatoria";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      var formValidate =
                          formKey.currentState?.validate() ?? false;
                      if (formValidate) {
                        var formatter = NumberFormat.simpleCurrency(
                          locale: "pt_BR",
                          decimalDigits: 2,
                        );

                        double weigth =
                            formatter.parse(weightEC.text) as double;
                        double stature =
                            formatter.parse(statureEc.text) as double;

                        _calcImc(weigth: weigth, stature: stature);
                      }
                    },
                    child: const Text("Calcular IMC"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
