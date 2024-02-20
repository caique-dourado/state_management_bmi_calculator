import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:state_management_bmi_calculator/bloc_pattern/imc_bloc_pattern_controller.dart';
import 'package:state_management_bmi_calculator/widgets/imc_gauge.dart';

class ImcBlocPattern extends StatefulWidget {
  const ImcBlocPattern({super.key});

  @override
  State<ImcBlocPattern> createState() => _ImcBlocPatternState();
}

class _ImcBlocPatternState extends State<ImcBlocPattern> {
  final formKey = GlobalKey<FormState>();
  final weightEC = TextEditingController();
  final statureEc = TextEditingController();
  final controller = ImcBlocPatternController();

  @override
  void dispose() {
    weightEC.dispose();
    statureEc.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ImcBlocPattern'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                StreamBuilder(
                    stream: controller.imcOut,
                    builder: (_, snapshot) {
                      var imc = snapshot.data?.imc ?? 0;
                      return ImcGauge(imc: imc);
                    }),
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

                        double weight =
                            formatter.parse(weightEC.text) as double;
                        double stature =
                            formatter.parse(statureEc.text) as double;

                        controller.calcImc(weight: weight, stature: stature);
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
