// 定数
final int N = 20;
final color DEFAULT_COLOR = color(255);
final color SWAPPING_COLOR = #FF0000;
final float SWAP_DELTA = 0.5; // 交換する速さ

// 状態変数
int state;
final int WAITING = 0;
final int SWAPPING = 1;
final int COMPLETED = 2;
int step;
float time; // 0から1
float xSrc;
float xDst;

// オブジェクト
Bar[] bars = new Bar[N];
Swaps bubbleSwaps = new Swaps();

// 初期化
void setup() {
  size(600, 400);
  initShuffle(bars);
  state = WAITING;
  step = 0;
  time = 0.0;
  bubbleSort(bars, bubbleSwaps);
  background(0);
}

void draw() {
  int src = bubbleSwaps.getSrc(step);
  int dst = bubbleSwaps.getDst(step);
  switch (state) {
  case WAITING:
    xSrc = bars[src].pos.x;
    xDst = bars[dst].pos.x;
    bars[src].c = SWAPPING_COLOR;
    bars[dst].c = SWAPPING_COLOR;
    state = SWAPPING;
    break;
  case SWAPPING:
    bars[src].pos.x = xSrc + (xDst - xSrc) * time;
    bars[dst].pos.x = xDst - (xDst - xSrc) * time;
    time += SWAP_DELTA;
    if (time >= 1.0) {
      int temp = bars[src].value;
      bars[src].value = bars[dst].value;
      bars[dst].value = temp;
      bars[src].pos.x = xSrc;
      bars[dst].pos.x = xDst;
      bars[src].c = DEFAULT_COLOR;
      bars[dst].c = DEFAULT_COLOR;
      if (step < bubbleSwaps.size() - 1) {
        step++;
        time = 0.0;
        state = WAITING;
        // チラつき防止
        return;
      } else {
        state = COMPLETED;
      }
    }
    break;
  case COMPLETED:
    break;
  }

  background(0);
  pushMatrix();
  scale(0.5);
  translate(0, height / 4);
  scale(width / (2 * N));
  for (int i = 0; i < N; i++) {
    bars[i].update();
  }
  popMatrix();
}