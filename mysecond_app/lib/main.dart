import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Shapes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Number Shapes'),
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
  bool _visibility = false;
  String _inVal = "";
  int _outVal = 0;
  String _outString = " ";

  bool perfectSq(int x) {
    double y = sqrt(x);
    int z = y.toInt();
    if (z * z == x) {
      return true;
    }
    else return false;
  }
  bool perfectCube(int x)
  {
    int cube;
    for (int i = 0; i <= x; i++) {
      cube = i * i * i;
      if (cube == x) {
        return true;
      }
      else if (cube > x) {
        return false;
      }
    }
  }

  void _checkNoOne(int _outVal) {
    setState(() {
      _outString = 'Number ' + _outVal.toString() + ' is neither TRIANGULAR or SQUARE';
    });
  }

  void _checkBoth(int _outVal) {
    setState(() {
      _outString = 'Number ' + _outVal.toString() + ' is both TRIANGULAR or SQUARE';
    });
  }

  void _checkTriangular(int _outVal) {
    setState(() {
      _outString = 'Number ' + _outVal.toString() + ' is TRIANGULAR ';
    });
  }

  void _checkSquare(int _outVal) {
    setState(() {
      _outString = 'Number ' + _outVal.toString() + ' is SQUARE';
    });
  }

  String checkNumber(int _outVal) {
    setState(() {
      if(perfectSq(_outVal) == true && perfectCube(_outVal) == true) {
        _checkBoth(_outVal);
      } else if(perfectSq(_outVal) == true) {
        _checkSquare(_outVal);
      } else if(perfectCube(_outVal) == true) {
        _checkTriangular(_outVal);
      }
      else _checkNoOne(_outVal);
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
            Text (
              'Please enter a number to see if it is square or triangular.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(),
              onChanged: (String value) {
                _inVal = value;
              },
            ),
            Visibility(
              child: AlertDialog(
                title: Text(_inVal,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: Text(_outString!=null?_outString:'default value'),
              ),
              visible: _visibility,

            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() => {
          _outVal = int.parse(_inVal),
          checkNumber(_outVal),
          _visibility = true,
        },
        child:Icon(
          Icons.verified,
        ),
      ),

    );
  }


}