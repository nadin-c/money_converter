import 'package:flutter/material.dart';

void main() {
  runApp(MoneyConverterApp());
}

class MoneyConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Converter',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MoneyConverterHome(),
    );
  }
}

class MoneyConverterHome extends StatefulWidget {
  @override
  _MoneyConverterHomeState createState() => _MoneyConverterHomeState();
}

class _MoneyConverterHomeState extends State<MoneyConverterHome> {
  final TextEditingController _amountController = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  double _convertedAmount = 0.0;

  final Map<String, double> conversionRates = {
    'USD': 1.0,
    'EUR': 0.85,
    'GBP': 0.75,
    'JPY': 110.0,
    'INR': 83.0,
    'AUD': 1.35,
    'CAD': 1.25,
    'CHF': 0.92,
    'CNY': 6.45,
    'NZD': 1.45
  };

  void _convertCurrency() {
    double amount = double.tryParse(_amountController.text) ?? 0.0;
    double fromRate = conversionRates[_fromCurrency]!;
    double toRate = conversionRates[_toCurrency]!;
    setState(() {
      _convertedAmount = (amount / fromRate) * toRate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Money Converter App'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Enter amount:',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Amount',
                ),
              ),
              SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DropdownButton<String>(
                    value: _fromCurrency,
                    onChanged: (String? newValue) {
                      setState(() {
                        _fromCurrency = newValue!;
                      });
                    },
                    items: conversionRates.keys
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(width: 24.0),
                  Text('to'),
                  SizedBox(width: 24.0),
                  DropdownButton<String>(
                    value: _toCurrency,
                    onChanged: (String? newValue) {
                      setState(() {
                        _toCurrency = newValue!;
                      });
                    },
                    items: conversionRates.keys
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _convertCurrency,
                child: Text('Convert'),
              ),
              SizedBox(height: 24.0),
              Text(
                'Converted amount:',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              Text(
                '$_convertedAmount $_toCurrency',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
