import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equestion = '0';
  String result = '0';
  String expression = '';
  double equestionFontSize = 38;
  double resultFontSize = 48;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        equestion = '0';
        result = '0';
        equestionFontSize = 38;
        resultFontSize = 48;
      } else if (buttonText == '⌫') {
        if (equestion.length == 1) {
          equestion = '0';
          result = '0';
          equestionFontSize = 38;
          resultFontSize = 48;
        } else {
          equestionFontSize = 48;
          resultFontSize = 38;
          equestion = equestion.substring(0, equestion.length - 1);
        }
      } else if (buttonText == '÷' ||
          buttonText == '×' ||
          buttonText == '-' ||
          buttonText == '+') {
        equestionFontSize = 48;
        resultFontSize = 38;
        String lastCharacter = equestion.substring(equestion.length - 1);
        if (!(lastCharacter == '÷' ||
            lastCharacter == '×' ||
            lastCharacter == '-' ||
            lastCharacter == '+')) {
          equestion = equestion + buttonText;
        }
      } else if (buttonText == '=') {
        equestionFontSize = 38;
        resultFontSize = 48;

        expression = equestion;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'Error';
        }
      } else {
        equestionFontSize = 48;
        resultFontSize = 38;
        if (equestion == '0') {
          equestion = buttonText;
        } else {
          equestion = equestion + buttonText;
        }
      }
    });
  }

  Widget buildButton(
    String buttonText,
    double buttonHeight,
    Color buttonColor,
  ) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(
            color: Colors.white,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        padding: const EdgeInsets.all(16),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  // color: Colors.red,
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Text(
                    equestion,
                    style: TextStyle(fontSize: equestionFontSize),
                  ),
                ),
                SizedBox(height: 1),
                Container(
                  // color: Colors.blue,
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Text(
                    result,
                    style: TextStyle(fontSize: resultFontSize),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton('C', 1, Colors.redAccent),
                        buildButton('⌫', 1, Colors.blue),
                        buildButton('÷', 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('7', 1, Colors.black54),
                        buildButton('8', 1, Colors.black54),
                        buildButton('9', 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('4', 1, Colors.black54),
                        buildButton('5', 1, Colors.black54),
                        buildButton('6', 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('1', 1, Colors.black54),
                        buildButton('2', 1, Colors.black54),
                        buildButton('3', 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('.', 1, Colors.black54),
                        buildButton('0', 1, Colors.black54),
                        buildButton('00', 1, Colors.black54),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton('×', 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('-', 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('+', 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('=', 2, Colors.blue),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
