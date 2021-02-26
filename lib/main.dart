import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fatness Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BmiMain(),
    );
  }
}

class BmiMain extends StatefulWidget {
  @override
  _BmiMainState createState() => _BmiMainState();
}

class _BmiMainState extends State<BmiMain> {
  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('비만도 계산기'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '키',
                ),
                keyboardType: TextInputType.number,
                controller: _heightController,
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return '키 입력';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '몸무게',
                ),
                keyboardType: TextInputType.number,
                controller: _weightController,
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return '몸무게 입력';
                  }
                  return null;
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 16.0),
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  child: Text('결과'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BmiResult(double.parse(_heightController.text.trim()), double.parse(_weightController.text.trim()))
                          )
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BmiResult extends StatelessWidget {
  BmiResult(this.height, this.weight);

  final double height;
  final double weight;

  @override
  Widget build(BuildContext context) {
    final bmi = weight / ((height / 100) * (height / 100));

    return Scaffold(
      appBar: AppBar(
        title: Text('비만도 계산기'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _calcBmi(bmi),
              style: TextStyle(
                fontSize: 36,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Icon(
              _calcIcon(bmi),
              color: Colors.green,
              size: 100
            ),
          ],
        ),
      ),
    );
  }

  String _calcBmi(double bmi) {
    var result = '저체중';

    if (bmi >= 35) {
      result = '고도 비만';
    } else if (bmi > 18.5) {
      result = '정상';
    }

    return result;
  }

  IconData _calcIcon(double bmi) {
    IconData iconData = Icons.sentiment_dissatisfied;
    if (bmi >= 35) {
      iconData = Icons.sentiment_very_dissatisfied;
    } else if (bmi > 18.5) {
      iconData = Icons.sentiment_satisfied;
    }

    return iconData;
  }
}

