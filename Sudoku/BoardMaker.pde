class BoardMaker {

  private Board board;

  BoardMaker(Board board) {
    this.board = board;
  }

  public void setupBoard() {
    fillDiagonalBoxes();
    solve();

    int openCellCount = 10;
    Position randomPos;

    for (int k = 0; k < 81 - openCellCount; k++) {
      randomPos = new Position(int(random(9)), int(random(9)));

      board.setNumber(randomPos, 0);
      board.getCell(randomPos).setUnchangeable();
    }
  }

  public Board getBoard() {
    return board;
  }

  private void fillDiagonalBoxes() {
    for (int i = 0; i < 3; i++) {
      Position diagonalPos = new Position(i*3, i*3);
      int randomNumber;

      for (int k = diagonalPos.getI(); k <diagonalPos.getI() + 3; k++) {
        for (int l = diagonalPos.getJ(); l < diagonalPos.getJ() + 3; l++) {
          Position pos = new Position(k, l);
          while (true) {
            randomNumber = (int)random(9) + 1;
            if (board.checkBoxForNumber(pos, randomNumber)) {
              break;
            }
          }
          board.setNumber(pos, randomNumber);
        }
      }
    }
  }

  private boolean solve() {
    Position emptyPos = board.getFirstEmptyPosition();

    if (emptyPos == null) {
      return true;
    }

    for (int num = 1; num < 10; num++) {
      if (board.checkAvailable(emptyPos, num)) {
        board.setNumber(emptyPos, num);
        if (solve()) {
          return true;
        }
        board.setNumber(emptyPos, 0);
      }
    }
    return false;
  }
}
