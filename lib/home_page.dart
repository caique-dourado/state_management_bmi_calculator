import 'package:flutter/material.dart';
import 'package:state_management_bmi_calculator/bloc_pattern/imc_bloc_pattern.dart';
import 'package:state_management_bmi_calculator/change_notifier/imc_change_notifier.dart';
import 'package:state_management_bmi_calculator/setState/imc_setstate_page.dart';
import 'package:state_management_bmi_calculator/value_notifier/imc_value_notifier_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _goToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () => _goToPage(context, const ImcSetstatePage()),
                child: const Text("SetState"),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () =>
                    _goToPage(context, const ImcValueNotifierPage()),
                child: const Text("ValueNotifier"),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () => _goToPage(context, const ImcChangeNotifier()),
                child: const Text("ChangeNotifier"),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () => _goToPage(context, const ImcBlocPattern()),
                child: const Text("Bloc Pattern (Streams)"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
