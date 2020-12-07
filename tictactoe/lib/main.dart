import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tictactoe/button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tic-tac-toe ',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'tic-tac-toe'),
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
  List<Button> buttonsList;
  var player1;
  var player2;
  var currPlayer;
  var x, y, z;
  bool _check = false;
  int _steps = 0;

  void initState() {
    super.initState();
    buttonsList = doInit();
  }

  List<Button> doInit() {
    player1 = new List();
    player2 = new List();
    currPlayer = 1;

    var gameButtons = <Button>[
      new Button(id: 1),
      new Button(id: 2),
      new Button(id: 3),
      new Button(id: 4),
      new Button(id: 5),
      new Button(id: 6),
      new Button(id: 7),
      new Button(id: 8),
      new Button(id: 9),
    ];
    return gameButtons;
  }

  void playGame(Button gameB) {
    setState(() {
      if (currPlayer == 1) {
        gameB.bg = Colors.red;
        currPlayer = 2;
        player1.add(gameB.id);
      } else {
        gameB.bg = Colors.blue;
        currPlayer = 1;
        player2.add(gameB.id);
      }
      gameB.enable = false;
      checkWinner();
    });
  }

  void checkWinner() {
    var winner = -1;

    //player1 check
    if (player1.contains(1)) {
      if (player1.contains(2) && player1.contains(3)) {
        winner = 1;
        x = 1;
        y = 2;
        z = 3;
        _steps++;
      } else if (player1.contains(4) && player1.contains(7)) {
        winner = 1;
        x = 1;
        y = 4;
        z = 7;
        _steps++;
      } else if (player1.contains(5) && player1.contains(9)) {
        winner = 1;
        x = 1;
        y = 5;
        z = 9;
        _steps++;
      }
    } else if (player1.contains(3)) {
      if (player1.contains(5) && player1.contains(7)) {
        winner = 1;
        x = 3;
        y = 5;
        z = 7;
        _steps++;
      } else if (player1.contains(6) && player1.contains(9)) {
        winner = 1;
        x = 3;
        y = 6;
        z = 9;
        _steps++;
      }
    } else if (player1.contains(5)) {
      if (player1.contains(4) && player1.contains(6)) {
        winner = 1;
        x = 5;
        y = 4;
        z = 6;
        _steps++;
      } else if (player1.contains(2) && player1.contains(8)) {
        winner = 1;
        x = 5;
        y = 2;
        z = 8;
        _steps++;
      }
    } else if (player1.contains(7) &&
        player1.contains(8) &&
        player1.contains(9)) {
      winner = 1;
      x = 7;
      y = 8;
      z = 9;
      _steps++;
    }

    //player2 check
    if (player2.contains(1)) {
      if (player2.contains(2) && player2.contains(3)) {
        winner = 2;
        x = 1;
        y = 2;
        z = 3;
        _steps++;
      } else if (player2.contains(4) && player2.contains(7)) {
        winner = 2;
        x = 1;
        y = 4;
        z = 7;
        _steps++;
      } else if (player2.contains(5) && player2.contains(9)) {
        winner = 2;
        x = 1;
        y = 5;
        z = 9;
        _steps++;
      }
    } else if (player2.contains(3)) {
      if (player2.contains(5) && player2.contains(7)) {
        winner = 2;
        x = 3;
        y = 5;
        z = 7;
        _steps++;
      } else if (player2.contains(6) && player2.contains(9)) {
        winner = 2;
        x = 3;
        y = 6;
        z = 9;
        _steps++;
      }
    } else if (player2.contains(5)) {
      if (player2.contains(4) && player2.contains(6)) {
        x = 5;
        y = 4;
        z = 6;
        _steps++;
      } else if (player2.contains(2) && player2.contains(8)) {
        winner = 2;
        x = 5;
        y = 2;
        z = 8;
        _steps++;
      }
    } else if (player2.contains(7) &&
        player2.contains(8) &&
        player2.contains(9)) {
      winner = 2;
      x = 7;
      y = 8;
      z = 9;
      _steps++;
    }
    if (winner != -1) {
      _steps = 0;
      _check = true;
    }
    if (_steps == 9) {
      _steps = 0;
      _check = true;
    }
  }

  void reset() {
    setState(() {
      buttonsList = doInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemBuilder: (BuildContext contex, int index) => new Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.yellow),
                ),
                child: RaisedButton(
                  onPressed: () => {
                    if (buttonsList[index].enable == true)
                      {playGame(buttonsList[index])},
                    if (_check == true)
                      {
                        _visibility = true,
                      }
                  },
                  disabledColor: buttonsList[index].bg,
                  child: AnimatedContainer(
                    width: 96,
                    height: 96,
                    color: buttonsList[index].bg,
                    duration: Duration(milliseconds: 800),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            child: RaisedButton(
                child: Text("Play Again!"),
                onPressed: () => {
                      reset(),
                      _visibility = false,
                    }),
            visible: _visibility,
          ),
        ],
      ),
    );
  }
}
