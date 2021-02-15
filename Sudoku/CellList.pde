import java.util.*;

class CellList implements Iterable<Cell> {
  private Cell[][] cells;

  private int verticalCellNumber = 9;
  private int hortizonalCellNumber = 9;

  CellList() {
    cells = new Cell[verticalCellNumber][hortizonalCellNumber];

    for (int i = 0; i < verticalCellNumber; i++) {
      for (int j = 0; j < hortizonalCellNumber; j++) {
        cells[i][j] = new Cell(new Position(i, j));
      }
    }
  }

  Iterator<Cell> iterator() {
    return new Iterator<Cell>() {
      private int currentIIndex = 0;
      private int currentJIndex = 0;

      @Override
        public boolean hasNext() {
        return currentIIndex < verticalCellNumber - 1 
          || currentJIndex < hortizonalCellNumber;
      }

      @Override
        public Cell next() {
        if (currentJIndex == verticalCellNumber) {
          currentJIndex = 0;
          currentIIndex++;
        }

        return cells[currentIIndex][currentJIndex++];
      }
    };
  }

  public Cell get(int i, int j) {
    return cells[i][j];
  }

  public boolean isOutOfBounds(Position pos) {
    return pos.getI() < 0 && pos.getI() >= verticalCellNumber
      && pos.getJ() < 0 && pos.getJ() >= hortizonalCellNumber;
  }

  public float getVerticalCellNum() {
    return verticalCellNumber;
  }

  public float getHortizonalCellNum() {
    return hortizonalCellNumber;
  }
}
