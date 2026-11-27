import 'package:flutter/material.dart';

void main() => runApp(
  const MaterialApp(debugShowCheckedModeBanner: false, home: Calculator()),
);

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String input = '';
  String result = '0';

  void calculate(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        result = '0';
      } else if (value == '⌫') {
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1);
        }
      } else if (value == '=') {
        try {
          final parts = input.split(RegExp(r'[+\-×÷]'));
          final numbers = parts.map(double.parse).toList();
          final op = input.replaceAll(RegExp(r'[0-9.]'), '');

          double a = numbers[0], b = numbers[1];
          double answer = op == '+'
              ? a + b
              : op == '-'
              ? a - b
              : op == '×'
              ? a * b
              : a / b;

          result = answer.toString();
          if (result.endsWith('.0')) {
            result = result.substring(0, result.length - 2);
          }
        } catch (_) {
          result = 'Error';
        }
      } else {
        input += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final buttons = [
      'C',
      '⌫',
      '÷',
      '×',
      '7',
      '8',
      '9',
      '-',
      '4',
      '5',
      '6',
      '+',
      '1',
      '2',
      '3',
      '=',
      '0',
      '.',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF101426),
      appBar: AppBar(
        toolbarHeight: 45,
        title: const Text('My Calculator', style: TextStyle(fontSize: 18)),
        centerTitle: true,
        backgroundColor: const Color(0xFF101426),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: const TextStyle(color: Colors.white70, fontSize: 22),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    result,
                    style: const TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.4,
                crossAxisSpacing: 7,
                mainAxisSpacing: 7,
              ),
              itemBuilder: (context, index) {
                final text = buttons[index];
                final isOperator = ['+', '-', '×', '÷', '='].contains(text);
                final isSpecial = ['C', '⌫'].contains(text);

                return ElevatedButton(
                  onPressed: () => calculate(text),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: isOperator
                        ? Colors.deepPurpleAccent
                        : isSpecial
                        ? Colors.teal
                        : const Color(0xFF252B43),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
