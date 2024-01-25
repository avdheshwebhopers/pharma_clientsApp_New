import 'package:flutter/material.dart';
import 'package:pharma_clients_app/utils/button.dart';
import '../../resources/app_colors.dart';
import '../../resources/constant_strings.dart';
import '../../utils/text_style.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  final TextEditingController _revenueController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _profitController = TextEditingController();
  double? _ptrResult;
  double? _ptsResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          title: TextWithStyle.appBarTitle(context, ConstantStrings.calculatorheading)
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16.0),
            TextField(
              controller: _revenueController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Revenue',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _costController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Cost of Goods Sold',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _profitController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Profit',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            Button(
              title: 'Calculate',
              onPress: _calculatePtrPts,
              loading: false,
            ),
            const SizedBox(height: 16.0),
            if (_ptrResult != null)
              Text(
                'PTR Result: ${_ptrResult!.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 24.0),
              ),
            if (_ptsResult != null)
              Text(
                'PTS Result: ${_ptsResult!.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 24.0),
              ),
          ],
        ),
      ),

    );
  }
  void _calculatePtrPts() {
    final double revenue = double.tryParse(_revenueController.text) ?? 0.0;
    final double cost = double.tryParse(_costController.text) ?? 0.0;
    final double profit = double.tryParse(_profitController.text) ?? 0.0;

    final double ptrResult = (profit / revenue) * 100.0;
    final double ptsResult = (profit / (revenue - cost)) * 100.0;

    setState(() {
      _ptrResult = ptrResult;
      _ptsResult = ptsResult;
    });
  }
}