import 'dart:io';

void main() {
  bool playAgain = true;
  while (playAgain) {
    List<String> board = List.filled(9, ' ');
    String currentPlayer = 'X';
    bool gameOver = false;

    while (!gameOver) {
      printBoard(board);
      int move = getValidMove(currentPlayer, board);
      board[move] = currentPlayer;

      if (checkWin(board, currentPlayer)) {
        printBoard(board);
        print('Player $currentPlayer wins!');
        gameOver = true;
      } else if (checkDraw(board)) {
        printBoard(board);
        print('It\'s a draw!');
        gameOver = true;
      } else {
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      }
    }

    playAgain = askToRestart();
  }
  print('Thanks for playing!');
}

void printBoard(List<String> board) {
  print('');
  for (int i = 0; i < 3; i++) {
    String row = '';
    for (int j = 0; j < 3; j++) {
      int position = i * 3 + j;
      String cell = board[position];
      row += cell == ' ' ? '${position + 1}' : cell;
      if (j < 2) row += ' | ';
    }
    print(row);
    if (i < 2) print('---------');
  }
  print('');
}

int getValidMove(String player, List<String> board) {
  while (true) {
    stdout.write('Player $player, enter your move (1-9): ');
    String input = stdin.readLineSync()?.trim() ?? '';
    try {
      int move = int.parse(input);
      if (move < 1 || move > 9) {
        print('Please enter a number between 1 and 9.');
        continue;
      }
      int index = move - 1;
      if (board[index] != ' ') {
        print('That position is already taken. Choose another.');
        continue;
      }
      return index;
    } catch (e) {
      print('Invalid input. Please enter a number between 1 and 9.');
    }
  }
}

bool checkWin(List<String> board, String player) {
  // Check rows
  for (int i = 0; i < 3; i++) {
    if (board[i * 3] == player &&
        board[i * 3 + 1] == player &&
        board[i * 3 + 2] == player) {
      return true;
    }
  }
  // Check columns
  for (int i = 0; i < 3; i++) {
    if (board[i] == player &&
        board[i + 3] == player &&
        board[i + 6] == player) {
      return true;
    }
  }
  // Check diagonals
  if (board[0] == player && board[4] == player && board[8] == player) {
    return true;
  }
  if (board[2] == player && board[4] == player && board[6] == player) {
    return true;
  }
  return false;
}

bool checkDraw(List<String> board) {
  return !board.contains(' ') && !checkWin(board, 'X') && !checkWin(board, 'O');
}

bool askToRestart() {
  while (true) {
    stdout.write('Would you like to play again? (Y/N): ');
    String input = stdin.readLineSync()?.trim().toUpperCase() ?? '';
    if (input == 'Y') return true;
    if (input == 'N') return false;
    print('Invalid input. Please enter Y or N.');
  }
}
