import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TicTacToeScreen(),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  bool gameOver = false;
  String winner = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tic Tac Toe'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  restartGame();
                },
                child: Text('Restart Game'),
              ),
              Text(
                'Player $currentPlayer\'s turn',
                style: TextStyle(fontSize: 24.0),
              ),
              SizedBox(height: 16.0),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0),
                itemCount: board.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      if (!gameOver && board[index] == '') {
                        setState(() {
                          board[index] = currentPlayer;
                          if (checkWin()) {
                            gameOver = true;
                            winner = currentPlayer;
                          } else if (checkTie()) {
                            gameOver = true;
                          } else {
                            currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
                          }
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: board[index] == 'X' ? Colors.blue : Colors.white,
                        border: Border.all(),
                      ),
                      child: Center(
                        child: Text(
                          board[index],
                          style: TextStyle(fontSize: 48.0),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16.0),
              gameOver
                  ? winner != null
                      ? Text(
                          'Player $winner wins!',
                        )
                      : Text(
                          'Game over: tie!',
                          style: TextStyle(fontSize: 24.0),
                        )
                  : Container(),
            ],
          ),
        ));
  }

  bool checkWin() {
    if ((board[0] == currentPlayer &&
            board[1] == currentPlayer &&
            board[2] == currentPlayer) ||
        (board[3] == currentPlayer &&
            board[4] == currentPlayer &&
            board[5] == currentPlayer) ||
        (board[6] == currentPlayer &&
            board[7] == currentPlayer &&
            board[8] == currentPlayer)) {
      return true;
    }

    // check columns
    if ((board[0] == currentPlayer &&
            board[3] == currentPlayer &&
            board[6] == currentPlayer) ||
        (board[1] == currentPlayer &&
            board[4] == currentPlayer &&
            board[7] == currentPlayer) ||
        (board[2] == currentPlayer &&
            board[5] == currentPlayer &&
            board[8] == currentPlayer)) {
      return true;
    }
    if ((board[0] == currentPlayer &&
            board[4] == currentPlayer &&
            board[8] == currentPlayer) ||
        (board[2] == currentPlayer &&
            board[4] == currentPlayer &&
            board[6] == currentPlayer)) {
      return true;
    }

    return false;
  }

  bool checkTie() {
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        return false;
      }
    }
    return true;
  }

  void restartGame() {
    setState(() {
      board = List.filled(9, '');
      currentPlayer = 'X';
      gameOver = false;
      winner = '';
    });
  }
}
