/*
 * ブロック崩し
 * written in Processing 3.3.2 by @nekketsuuu (2017)
 * LICENSE: The Unlicense
 */

// プレイの状態
int state;
final int WAITING   = 0;
final int PLAYING   = 1;
final int GAMEOVER  = 2;
final int GAMECLEAR = 3;

// スコア
int score;

/*
 * ゲームオブジェクトたち
 * fooW は foo の幅。fooH は foo の高さ。
 */
Ball ball;
Rect[] barAndBlocks; // インデックス0がバー、それ以外はブロック
Rect bar;
final float barW = 100;
final float barH = 20;
final int blockX = 5;
final int blockY = 3;
final float blockW = 100;
final float blockH = 75;
final int objectNum = blockX * blockY + 1;

void init() {
  // スコアの初期化
  score = 0;

  // オブジェクトの初期化
  ball = new Ball(width * 0.5, height - barH - 20.0); // TODO
  barAndBlocks = new Rect[blockX * blockY + 1];
  barAndBlocks[0] = new Rect(
    (width - barW) * 0.5, 
    height - barH, 
    barW, 
    barH, 
    false);
  bar = barAndBlocks[0];
  for (int j = 0; j < blockY; j++) {
    for (int i = 0; i < blockX; i++) {
      barAndBlocks[j * blockX + i + 1] = new Rect(
        i * barW + (width - blockX * blockW) * 0.5, 
        j * barH + 50.0, 
        barW, 
        barH, 
        true);
    }
  }

  // 画面の初期化
  background(255);
  smooth();
  stroke(0);
}

void setup() {
  size(600, 400);
  state = WAITING;
  init();
}

void draw() {
  // 画面全体を塗りつぶす
  // 透明度付きなので残像が残る
  fill(255, 80);
  rect(0, 0, width, height);

  // スコアの表示
  fill(0);
  textSize(24);
  textAlign(LEFT);
  text("Score: " + str(score), 5, 24);

  switch (state) {
  case WAITING:
    textAlign(CENTER);
    text("Click!", 0, 300, width, 350);
    if (mousePressed) {
      // クリックの文字を消す
      fill(255);
      rect(0, 300, width, 350);
      // 初期化
      init();
      // ボールの方向を決める
      ball.setDir(random(-1.0, 1.0), -1.0);
      state = PLAYING;
    }
    break;
  case PLAYING:
    // バーの移動
    final float delta = 5.0;
    float dx = 3.0;
    if (mouseX > bar.pos.x + barW * 0.5 + delta) {
      bar.moveDx(dx);
    } else if (mouseX < bar.pos.x + barW * 0.5 - delta) {
      bar.moveDx(-dx);
    }

    // ゲームオーバー・クリア判定
    if (ball.pos.y + ball.radius >= height) {
      state = GAMEOVER;
    }
    if (score >= blockX * blockY) {
      state = GAMECLEAR;
    }
    break;
  case GAMEOVER:
    ball.setDir(0.0, 0.0);
    ball.c = #0000FF;
    state = WAITING;
    break;
  case GAMECLEAR:
    ball.setDir(0.0, 0.0);
    ball.c = #FF0000;
    state = WAITING;
    break;
  }

  // 衝突判定したり描いたりする
  for (int i = 0; i < objectNum; i++) {
    barAndBlocks[i].update();
  }
  ball.update(barAndBlocks);
}
