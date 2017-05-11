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
float time; // 0から1

// オブジェクト
Bar[] bars = new Bar[N];
BubbleSort bubbleVars = new BubbleSort();

// 初期化
void setup() {
  size(600, 400);
  initShuffle(bars);
  state = WAITING;
  time = 0.0;
  background(0);
}

void draw() {
  switch (state) {
  case WAITING:
    bubbleSort(bars, bubbleVars);
    break;
  case SWAPPING:
    bars[bubbleVars.swapFrom].pos.x = bubbleVars.xFrom + (bubbleVars.xTo - bubbleVars.xFrom) * time;
    bars[bubbleVars.swapTo].pos.x   = bubbleVars.xTo   - (bubbleVars.xTo - bubbleVars.xFrom) * time;
    time += SWAP_DELTA;
    if (time >= 1.0) {
      time = 0.0;
      // 数値誤差を消す
      bars[bubbleVars.swapFrom].pos.x = bubbleVars.xTo;
      bars[bubbleVars.swapTo].pos.x   = bubbleVars.xFrom;
      // 交換完了
      swapEnd(bars, bubbleVars.swapFrom, bubbleVars.swapTo);
      // チラつき防止
      return;
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