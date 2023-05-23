import 'package:flutter/material.dart';

class ConversionScreen extends StatefulWidget {
  ConversionScreen({Key? key}) : super(key: key);

  @override
  _ConversionScreenState createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  double _kilometers = 0;
  double _miles = 0;

  void _convert() {
    setState(() {
      _miles = _kilometers * 0.621371;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text("Kilometer to Mile Converter"),
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
                  _kilometers = double.tryParse(value) ?? 0;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                  labelText: "Kilometers",
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _convert,
              child: Text('CONVERT'),
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: Text(
                'Miles: $_miles',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
