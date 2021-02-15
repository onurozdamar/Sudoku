interface WriteMode {
  public void write(Board board, Cell selectedCell, int number);
}

class WriteDirect implements WriteMode {
  public void write(Board board, Cell selectedCell, int number) {
    selectedCell.setNumber(number);
    board.deleteFromArrayWhoOverlap(
      selectedCell.getPosition(), number);
  }
}

class WriteToArray implements WriteMode {
  public void write(Board board, Cell selectedCell, int number) {
    selectedCell.setNumberArray(number);
  }
}
