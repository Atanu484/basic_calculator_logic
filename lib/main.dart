import 'package:flutter/material.dart';
import 'controller/calculator_controller.dart';
import 'model/history_model.dart';
import 'screens/conversion_screen.dart';
import 'services/database_service.dart';
import 'screens/history_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // This line will remove the debug banner.
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,  // This line will apply platform-specific density for UI.
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();
  final CalculatorController _calculatorController = CalculatorController();
  final DatabaseService _dbService = DatabaseService.instance;
  String _displayResult = '';
  double _number1 = 0;
  double _number2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,  // This line will make the title centered.
        elevation: 0,  // This line will remove the shadow of the AppBar.
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
            ),
            ListTile(
              leading: Icon(Icons.swap_calls),
              title: Text('Convert'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ConversionScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('History'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryScreen()));
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter a number',
                  labelStyle: TextStyle(fontSize: 18),  // Style the label text
                ),
                onChanged: (value) {
                  _number1 = double.tryParse(value) ?? 0;
                },
              ),
              SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter another number',
                  labelStyle: TextStyle(fontSize: 18),  // Style the label text
                ),
                onChanged: (value) {
                  _number2 = double.tryParse(value) ?? 0;
                },
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add, size: 30),  // Increase the size of the icon
                    onPressed: () => _calculate(Operation.add),
                  ),
                  IconButton(
                    icon: Icon(Icons.remove, size: 30),  // Increase the size of the icon
                    onPressed: () => _calculate(Operation.subtract),
                  ),
                  IconButton(
                    icon: Icon(Icons.clear, size: 30),  // Increase the size of the icon
                    onPressed: () => _calculate(Operation.multiply),
                  ),
                  IconButton(
                    icon: Icon(Icons.format_line_spacing, size: 30),  // Increase the size of the icon
                    onPressed: () => _calculate(Operation.divide),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text(
                'Result: $_displayResult',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _calculate(Operation operation) async {
    _calculatorController.setNumber1(_number1);
    _calculatorController.setNumber2(_number2);
    double result = 0;
    try {
      result = _calculatorController.performOperation(operation);
      _displayResult = result.toString();
      String operationString = _calculatorController.operationToString(operation);
      await _dbService.create(HistoryModel(id: 0, calculation: '$_number1 $operationString $_number2 = $_displayResult', timestamp: DateTime.now()));
    } catch (e) {
      _displayResult = 'Error: ${e.toString()}';
    }
    setState(() {});
  }
}
