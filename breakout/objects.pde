/*
 * ブロック崩し
 * written in Processing 3.3.2 by @nekketsuuu (2017)
 * LICENSE: The Unlicense
 */

/*
 * ブロックとバー
 * draw() のたびに update() する
 */
class Rect {
  // データ
  PVector pos; // 左上の座標
  float w;
  float h;
  color c;
  boolean isVisible;
  boolean isBlock;

  // 初期化
  Rect(float x, float y, float w, float h, boolean isBlock) {
    this.pos = new PVector(x, y);
    this.w = w;
    this.h = h;
    this.c = color(127);
    this.isVisible = true;
    this.isBlock = isBlock;
  }

  // 機能
  void update() {
    if (isVisible) {
      fill(c);
      rect(pos.x, pos.y, w, h);
    }
  }
  void moveDx(float dx) {
    pos.x += dx;
    if (pos.x < -w * 0.5) {
      pos.x = -w * 0.5;
    }
    if (pos.x > width + w * 0.5) {
      pos.x = width + w * 0.5;
    }
  }
}

/*
 * ボール
 * draw() のたびに update() する
 */
class Ball {
  // データ
  PVector pos; // 中心の座標
  float radius;
  PVector dir;
  float speed;
  color c;

  // 初期化
  void init(float x, float y, float r) {
    this.pos = new PVector(x, y);
    this.radius = r;
    this.dir = new PVector(0.0, 0.0);
    this.speed = 5.0;
    this.c = color(0);
  }
  Ball(float x, float y) {
    init(x, y, 10.0);
  }
  Ball(float x, float y, float r) {
    init(x, y, r);
  }

  // 機能
  void update(Rect[] rects) {
    // バーやブロックとの衝突判定
    for (int i = 0; i < rects.length; i++) {
      collisionRect(this, rects[i]);
    }

    // 壁との衝突 (下の壁にはぶつからない)
    if (pos.x - radius < 0.0 || pos.x + radius > width) {
      dir.x *= -1.0;
    }
    if (pos.y - radius < 0.0) {
      dir.y *= -1.0;
    }

    // 動かす
    pos.add(PVector.mult(dir, speed));

    // 描く
    fill(c);
    ellipse(pos.x, pos.y, radius, radius);
  }
  void setDir(float x, float y) {
    dir.set(x, y).normalize();
  }
}

void collisionRect(Ball ball, Rect rect) {
  if (rect.isVisible) {
    // 円の中心から一番近い点を求める
    int vertical   = 0; // 0: 中, 1: 左, 2: 右
    int horizontal = 0; // 0: 中, 1: 上, 2: 下
    PVector nearest = new PVector();
    if (ball.pos.x <= rect.pos.x) {
      // 左の辺上
      nearest.x = rect.pos.x;
      vertical = 1;
    } else if (ball.pos.x >= rect.pos.x + rect.w) {
      // 右の辺上
      nearest.x = rect.pos.x + rect.w;
      vertical = 2;
    } else {
      nearest.x = ball.pos.x;
    }
    if (ball.pos.y <= rect.pos.y) {
      // 上の辺上
      nearest.y = rect.pos.y;
      horizontal = 1;
    } else if (ball.pos.y >= rect.pos.y + rect.h) {
      // 下の辺上
      nearest.y = rect.pos.y + rect.h;
      horizontal = 2;
    } else {
      nearest.y = ball.pos.y;
    }

    // その点からの距離を調べ、円の半径より小さければ衝突している
    // ただし、もし既に長方形から出て行こうとしているなら無視する
    if (nearest.sub(ball.pos).magSq() <= ball.radius * ball.radius) {
      if ((horizontal == 1 && ball.dir.y > 0.0) || (horizontal == 2 && ball.dir.y < 0.0)) {
        ball.dir.y *= -1.0;
        if (rect.isBlock) {
          rect.isVisible = false;
          score++;
        }
      }
      if ((vertical == 1 && ball.dir.x > 0.0) || (vertical == 2 && ball.dir.x < 0.0)) {
        ball.dir.x *= -1.0;
        if (rect.isBlock && rect.isVisible) {
          rect.isVisible = false;
          score++;
        }
      }
    }
  }
}