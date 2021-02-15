
GameManager oy;

void setup() {
  size(450, 450);

  oy = new GameManager();

  oy.oyunuBaslat();
}

void draw() {
  oy.draw();
}

void mousePressed() {
  oy.selectCell(mouseX, mouseY);
}

void keyPressed() {
  int keyValue = key - 48;//ascii değerini rakama dönüştür
  oy.keyPressed(keyValue);
}
