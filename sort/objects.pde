class Bar {
  PVector pos;
  int value;
  color c;
  boolean isSwapping;
  int swapTo;

  // 初期化
  Bar(float x, float y, int value) {
    this.pos = new PVector(x, y);
    this.value = value;
    this.c = DEFAULT_COLOR;
    this.isSwapping = false;
  }

  // 機能
  void update() {
    pushMatrix();
    translate(pos.x + 0.5, pos.y);
    noStroke();
    fill(c);
    rect(0, N - value, 1, value);
    popMatrix();
  }
}

void initShuffle(Bar[] bars) {
  // フィッシャーとイェーツのシャッフルアルゴリズムの改造版を使用
  for (int i = 0; i < bars.length; i++) {
    bars[i] = new Bar(2 * i, 0, 0);
    int j = int(random(0, i + 1));
    if (i != j) {
      bars[i].value = bars[j].value;
    }
    bars[j].value = i + 1;
  }
}