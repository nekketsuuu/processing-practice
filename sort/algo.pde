void swapStart(Bar[] bars, int i, int j) {
  bars[i].isSwapping = true;
  bars[i].c = SWAPPING_COLOR;
  bars[j].isSwapping = true;
  bars[j].c = SWAPPING_COLOR;
  state = SWAPPING;
}
void swapEnd(Bar[] bars, int i, int j) {
  bars[i].isSwapping = false;
  bars[i].c = DEFAULT_COLOR;
  bars[j].isSwapping = false;
  bars[j].c = DEFAULT_COLOR;
  int tmpValue = bars[i].value;
  bars[i].value = bars[j].value;
  bars[j].value = tmpValue;
  float tmpPosX = bars[i].pos.x;
  bars[i].pos.x = bars[j].pos.x;
  bars[j].pos.x = tmpPosX;
  state = WAITING;
}

/*
 * バブルソート
 */
class BubbleSort {
  // バブルソートで使うインデックス
  int i;
  int j;
  // 要素を交換するとき、データを覚えておく
  int swapFrom;
  int swapTo;
  float xFrom;
  float xTo;

  BubbleSort() {
    i = 0;
    j = 0;
    swapFrom = 0;
    swapTo = 0;
    xFrom = 0.0;
    xTo = 0.0;
  }
}

void bubbleSort(Bar[] bars, BubbleSort vars) {
  if (vars.i >= bars.length - 1) {
    state = COMPLETED;
    return;
  }

  if (bars[vars.j].value > bars[vars.j + 1].value) {
    swapStart(bars, vars.j, vars.j + 1);
    vars.swapFrom = vars.j;
    vars.swapTo   = vars.j + 1;
    vars.xFrom = bars[vars.j].pos.x;
    vars.xTo   = bars[vars.j + 1].pos.x;
  }

  if (vars.j >= bars.length - vars.i - 2) {
    vars.i++;
    vars.j = 0;
  } else {
    vars.j++;
  }
}