import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency convertor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Currency convertor'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _inVal;
  double _outVal = 0;
  String error = null;
  bool show = false;
  bool _isNumeric(String _inVal) {
    if (_inVal == null) {
      return false;
    }
    return double.tryParse(_inVal) != null;
  }

  void _convertFunc(String _inVal) {
    setState(() {
      _outVal = double.parse(_inVal) * 4.5;
      print(_outVal);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true ,
        title: Text(widget.title),

      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Image(
              image: NetworkImage('https://www.piatapresei.ro/wp-content/uploads/2019/08/img.jpg'),

            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                hintText: 'enter the amount in EUR',
                errorText: error,
              ),
              onChanged: (String value) {
                _inVal = value;
              },
            ),
            RaisedButton(
                onPressed: () {
                  if(_isNumeric(_inVal) == true) {
                    error = null;
                    _convertFunc(_inVal);
                    show = true;
                  }
                  else {
                    setState(() {
                      error = 'please enter a number';
                    });
                  }
                },
              child: const Text('CONVERT'),
                ),
            Column(
                children: <Widget>[
                  if(show == true)
                    Text(
                    _outVal.toString() + ' RON',
                    style: Theme.of(context).textTheme.headline3,
                ),
                ],
            ),
          ]
        ),
      ),
    );
  }
}
