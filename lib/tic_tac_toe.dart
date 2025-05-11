import 'dart:io';

class TicTacToe {
  List<String> board = List.generate(9, (index) => (index + 1).toString());
  String currentPlayer = 'X';

  void startGame() {
    print("Welcome to Tic-Tac-Toe!");
    while (true) {
      printBoard();
      int move = getPlayerMove();
      makeMove(move);
      if (checkWin()) {
        printBoard();
        print("Player $currentPlayer wins!");
        break;
      }
      if (checkDraw()) {
        printBoard();
        print("It's a draw!");
        break;
      }
      switchPlayer();
    }
    askRestart();
  }

  void printBoard() {
    print('\n');
    for (int i = 0; i < 9; i += 3) {
      print('${board[i]} | ${board[i + 1]} | ${board[i + 2]}');
      if (i < 6) print('--+---+--');
    }
    print('\n');
  }

  int getPlayerMove() {
    int move;
    while (true) {
      stdout.write("Player $currentPlayer, enter your move (1-9): ");
      String? input = stdin.readLineSync();
      if (input == null || int.tryParse(input) == null) {
        print("Invalid input. Please enter a number from 1 to 9.");
        continue;
      }
      move = int.parse(input) - 1;
      if (move < 0 || move > 8) {
        print("Input out of range. Try again.");
      } else if (board[move] == 'X' || board[move] == 'O') {
        print("Cell already taken. Choose another one.");
      } else {
        break;
      }
    }
    return move;
  }

  void makeMove(int index) {
    board[index] = currentPlayer;
  }

  bool checkWin() {
    List<List<int>> winPositions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pos in winPositions) {
      if (board[pos[0]] == currentPlayer &&
          board[pos[1]] == currentPlayer &&
          board[pos[2]] == currentPlayer) {
        return true;
      }
    }
    return false;
  }

  bool checkDraw() {
    return board.every((cell) => cell == 'X' || cell == 'O');
  }

  void switchPlayer() {
    currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
  }

  void askRestart() {
    stdout.write("Do you want to play again? (y/n): ");
    String? answer = stdin.readLineSync();
    if (answer != null && answer.toLowerCase() == 'y') {
      board = List.generate(9, (index) => (index + 1).toString());
      currentPlayer = 'X';
      startGame();
    } else {
      print("Thanks for playing!");
    }
  }
}

void main() {
  TicTacToe game = TicTacToe();
  game.startGame();
}
