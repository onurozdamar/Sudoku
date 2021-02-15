class Board {

  private float cellSize = 50;

  private float boardWidth = 450;
  private float boardHeight = 450;

  CellList cells;

  public Board() {
    cells = new CellList();
  }

  public Cell getCell(Position pos) {
    if (cells.isOutOfBounds(pos)) return null;

    return cells.get(pos.getI(), pos.getJ());
  }

  public Cell getSelectedCell() {
    for (Cell c : cells) {
      if (c.isSelected()) {
        return c;
      }
    }
    return null;
  }

  public void setAllOverlappingCellsFalse() {
    for (Cell c : cells) {
      if (c.isOverlapping()) {
        c.setOverlapping(false);
      }
    }
  }

  public Cell getCell(float mx, float my) { // get cell with mouse coordinate
    Position mousePos = new Position(int(my / cellSize), int(mx / cellSize));
    return getCell(mousePos);
  }

  public Position getBoxPosition(Position pos) {
    int x = pos.getI() / 3;
    int y = pos.getJ() / 3;
    x = x * 3;
    y = y * 3;
    return new Position(x, y);
  }

  public void unselectAll() {
    for (Cell c : cells) {
      if (c.isSelected()) {
        c.unSelect();
      }
    }
  }

  public boolean checkBoxForNumber(Position pos, int number) {
    Position boxPos = getBoxPosition(pos);
    // olduğu 9 kareyi kontrol et
    for (int k = boxPos.getI(); k < boxPos.getI() + 3; k++) { 
      for (int l = boxPos.getJ(); l < boxPos.getJ() + 3; l++) {
        if (cells.get(k, l).getNumber() == number) {
          return false;
        }
      }
    }
    return true;
  }

  public Position getFirstEmptyPosition() { // bulduğu ilk boş konumu döner
    for (Cell c : cells) {
      if (c.isEmpty()) {
        return c.getPosition();
      }
    }
    return null;
  }

  public void setNumber(Position pos, int number) {
    getCell(pos).setNumber(number);
  }

  public void paintSameNumbers(int number) {
    //seçtiğimiz sayıyla aynı olanları aynı renge boya

    for (Cell c : cells) {
      if (c.canItPaint(number)) {
        c.setColor(#6DA4D8);
      } else {
        c.setColor(#FFFFFF);
      }
    }
  }

  public boolean checkAvailable(Position pos, int number) {
    // gelen posizyona verilen sayi yazılabilir mi
    if (number == 0) {
      return true;
    }

    for (int k = 0; k < cells.getVerticalCellNum(); k++) { // dikeyi kontrol et
      if (cells.get(k, pos.getJ()).getNumber() == number) {
        return false;
      }
    }

    for (int k = 0; k < cells.getHortizonalCellNum(); k++) { // yatayı kontrol et
      if (cells.get(pos.getI(), k).getNumber() == number) {
        return false;
      }
    }

    Position boxPos = getBoxPosition(pos);

    for (int k = boxPos.getI(); k < boxPos.getI() + 3; k++) { 
      for (int l = boxPos.getJ(); l < boxPos.getJ() + 3; l++) {
        if (cells.get(k, l).getNumber() == number) {
          return false;
        }
      }
    }

    return true;
  }

  public Cell getOverlapCell(Position pos, int number) {
    for (int k = 0; k < cells.getVerticalCellNum(); k++) { // dikeyi kontrol et
      if (cells.get(k, pos.getJ()).getNumber() == number) {
        return getCell(new Position(k, pos.getJ()));
      }
    }

    for (int k = 0; k < cells.getHortizonalCellNum(); k++) { // yatayı kontrol et
      if (cells.get(pos.getI(), k).getNumber() == number) {
        return getCell(new Position(pos.getI(), k));
      }
    }

    Position boxPos = getBoxPosition(pos);

    for (int k = boxPos.getI(); k < boxPos.getI() + 3; k++) { 
      for (int l = boxPos.getJ(); l < boxPos.getJ() + 3; l++) {
        if (cells.get(k, l).getNumber() == number) {
          return getCell(new Position(k, l));
        }
      }
    }

    return null;
  }

  public void deleteFromArrayWhoOverlap(Position pos, int sayi) {
    if (sayi == 0) return;

    for (int k = 0; k < cells.getVerticalCellNum(); k++) {
      cells.get(k, pos.getJ()).deleteFromArray(sayi);
    }

    for (int k = 0; k < cells.getHortizonalCellNum(); k++) {
      cells.get(pos.getI(), k).deleteFromArray(sayi);
    }

    Position boxPos = getBoxPosition(pos);

    for (int k = boxPos.getI(); k < boxPos.getI() + 3; k++) { 
      for (int l = boxPos.getJ(); l < boxPos.getJ() + 3; l++) {
        cells.get(k, l).deleteFromArray(sayi);
      }
    }
  }

  public float getCellSize() {
    return cellSize;
  }

  public float getWidth() {
    return boardWidth;
  }

  public float getHeight() {
    return boardHeight;
  }

  public CellList getCells() {
    return cells;
  }
}
