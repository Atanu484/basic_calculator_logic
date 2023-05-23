import 'package:flutter/material.dart';
import 'controller/calculator_controller.dart';
import 'screens/conversion_screen.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
      home: CalculatorHomePage(title: 'Flutter Calculator'),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  CalculatorHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  final CalculatorController _controller = CalculatorController();
  double _number1 = 0;
  double _number2 = 0;
  String _result = '0';

  void _calculate(Operation operation) {
    setState(() {
      _controller.setNumber1(_number1);
      _controller.setNumber2(_number2);
      _result = _controller.performOperation(operation).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text(widget.title!),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                onChanged: (value) {
                  _number1 = double.tryParse(value) ?? 0;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                  labelText: "Number 1",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                onChanged: (value) {
                  _number2 = double.tryParse(value) ?? 0;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                  labelText: "Number 2",
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _calculate(Operation.add),
                  child: Text('ADD'),
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                ),
                ElevatedButton(
                  onPressed: () => _calculate(Operation.subtract),
                  child: Text('SUBTRACT'),
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                ),
                ElevatedButton(
                  onPressed: () => _calculate(Operation.multiply),
                  child: Text('MULTIPLY'),
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                ),
                ElevatedButton(
                  onPressed: () => _calculate(Operation.divide),
                  child: Text('DIVIDE'),
                  style: ElevatedButton.styleFrom(primary: Colors.purple),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: Text(
                'Result: $_result',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConversionScreen()),
                );
              },
              child: Text('Go to KM-Mile Converter'),
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
