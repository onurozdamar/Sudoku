class GameManager {

  BoardMaker boardMaker;
  Board board;

  GameManager() {
    board = new Board();
    boardMaker = new BoardMaker(board);
  }

  void oyunuBaslat() {
    boardMaker.setupBoard();
  }

  void selectCell(float mx, float my) {//gelen mouse koordinatlarındaki kareyi seçer
    Cell selectedCell = board.getCell(mx, my);

    if (selectedCell == null) return;

    board.unselectAll();

    selectedCell.select();
    board.paintSameNumbers(selectedCell.getNumber());
    board.setAllOverlappingCellsFalse();
  }

  private WriteMode writer = new WriteDirect();
  private boolean writeDirect = true;

  void keyPressed(int keyValue) {

    if (keyValue == 61) { // keyValue == 'm' change write mode
      writeDirect = !writeDirect;
      writer = writeDirect ? new WriteDirect() : new WriteToArray();
      return;
    }

    board.setAllOverlappingCellsFalse();

    Cell selectedCell = board.getSelectedCell();

    if (!selectedCell.isChangeable()) return;

    if (!board.checkAvailable(selectedCell.getPosition(), keyValue)) {
      Cell overlapCell = board.getOverlapCell(selectedCell.getPosition(), keyValue);
      overlapCell.setOverlapping(true);
      return;
    }

    writer.write(board, selectedCell, keyValue);
  }

  void draw() {
    background(0);

    for (Cell c : board.getCells()) {
      c.draw();
    }

    strokeWeight(2);
    stroke(#646363);
    line(board.getCellSize() * 3, 0, board.getCellSize() * 3, board.getHeight());
    line(board.getCellSize() * 6, 0, board.getCellSize() * 6, board.getHeight());
    line(0, board.getCellSize() * 3, board.getWidth(), board.getCellSize() * 3);
    line(0, board.getCellSize() * 6, board.getWidth(), board.getCellSize() * 6);
  }
}
