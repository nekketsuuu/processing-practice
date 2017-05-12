class Swaps {
  ArrayList<int[]> mem;
  
  Swaps() {
    mem = new ArrayList<int[]>();
  }
  
  int size() {
    return mem.size();
  }
  void add(int i, int j) {
    int[] swap = {i, j};
    mem.add(swap);
  }
  int getSrc(int step) {
    return mem.get(step)[0];
  }
  int getDst(int step) {
    return mem.get(step)[1];
  }
}

void swap(int[] values, Swaps swaps, int i, int j) {
  swaps.add(i, j);
  int temp = values[i];
  values[i] = values[j];
  values[j] = temp;
}

void bubbleSort(Bar[] bars, Swaps swaps) {
  int[] values = new int[N];
  for (int i = 0; i < N; i++) {
    values[i] = bars[i].value;
  }
  
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N - i - 1; j++) {
      if (values[j] > values[j+1]) {
        swap(values, swaps, j, j+1);
      }
    }
  }
}