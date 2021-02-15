class Cell {

  private Position position;

  private float cellSize = 50;

  private int number;

  private boolean selected;
  private boolean changeable = false;

  private boolean overlapping = false;

  private color cellColor = color(255);

  private int[] possibleNumbersArray = new int[9];

  Cell(Position position) {
    this.position = position;
    position.calculateX(cellSize);
    position.calculateY(cellSize);
  }

  void draw() {
    if (selected) {
      strokeWeight(2.5);
      stroke(0);
    } else {
      strokeWeight(1);
      stroke(#898787);
    }

    if (overlapping) {
      strokeWeight(2.5);
      stroke(255, 0, 0);
    }

    fill(cellColor);//#6DA4D8
    rect(position.getX(), position.getY(), cellSize, cellSize);

    if (number != 0) {
      fill(0);
      textSize(16);
      textAlign(CENTER);
      text(number + "", position.getX() + cellSize/2, position.getY() + cellSize/2 + 4);
    } else {
      drawArray();
    }
  }

  private void drawArray() {
    float x = position.getX() + 10;
    float y = position.getY() + 15;

    fill(0);
    textSize(10);
    textAlign(LEFT);

    for (int i = 0; i < 9; i++) {
      if (i != 0 && i % 3 == 0) {
        y += 15;
        x -= 30;
      }
      text(((possibleNumbersArray[i] == 0) ? "  " : possibleNumbersArray[i]+" "), x, y);
      x += 10;
    }
  }

  void setNumber(int number) {
    if (isInTheBounds(number)) {
      this.number = number;
      deleteFromArray(number);
    }
  }

  void select() {
    selected = !selected;
  }

  void unSelect() {
    selected = false;
  }

  void setColor(color c) {
    this.cellColor = c;
  }

  void setUnchangeable() {
    changeable = true;
  }

  void setOverlapping(boolean overlapping) {
    this.overlapping = overlapping;
  }

  void setNumberArray(int number) {
    if (!isInTheBounds(number)) return;

    if (number == 0) {
      deleteFromArray(number);
      this.number = number;
      return;
    }

    boolean arrayContainsNumber = isArrayContains(number);

    if (arrayContainsNumber) {
      deleteFromArray(number);
    } else {
      possibleNumbersArray[number - 1] = number;
    }
  }

  boolean canItPaint(int number) {
    return !isEmpty() && this.number == number
      || isArrayContains(number);
  }

  boolean isEmpty() {
    return number == 0;
  }

  void deleteFromArray(int number) {
    if (!isInTheBounds(number)) return;

    if (number == 0) {
      for (int i = 0; i < 9; i++) {
        possibleNumbersArray[i] = 0;
      }
      return;
    }
    possibleNumbersArray[number - 1] = 0;
  }

  boolean isArrayContains(int number) {
    if (number == 0 || !isInTheBounds(number)) return false;

    return possibleNumbersArray[number - 1] == number;
  }

  boolean isInTheBounds(int number) {
    return number >= 0 && number < 10;
  }
  boolean isOverlapping() {
    return overlapping;
  }

  boolean isChangeable() {
    return changeable;
  }

  boolean isSelected() {
    return selected;
  }

  int getNumber() {
    return number;
  }

  Position getPosition() {
    return position;
  }
}
