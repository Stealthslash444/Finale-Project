class Number {
  int x, y;
  int number;
  int finalNumber;
  Number(int x, int y) {
    this.x=x;
    this.y=y;
  }

  void display() {
    fill(0);
    textSize(size);
    text(nf(number), x, y);
  }
}