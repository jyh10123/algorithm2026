import java.util.ArrayList;

int n = 20;
int[] arr = new int[n];

ArrayList<int[]> steps = new ArrayList<int[]>();

String sortName = "Bubble Sort";

int step = 0;
boolean playing = true;

void setup() {
  size(1000, 600);
  frameRate(10);

  resetArray();
  startSort(1);
}

void draw() {
  background(245);

  fill(0);
  textSize(30);
  text("Sorting Animation", 350, 45);

  textSize(20);
  text("Algorithm: " + sortName, 40, 90);

  textSize(15);
  text("1: Bubble   2: Insertion   3: Merge   4: Quick   5: Heap",
       40, 125);

  text("SPACE: Pause/Play     R: Restart", 40, 155);

  if (steps.size() == 0) return;

  int[] current = steps.get(step);

  // 막대그래프 출력
  for (int i = 0; i < n; i++) {

    float barWidth = 900.0 / n;
    float x = 40 + i * barWidth;
    float h = current[i] * 4;

    if (step == steps.size() - 1) {
      fill(100, 200, 150);
    } else {
      fill(100, 150, 255);
    }

    noStroke();
    rect(x, height - h - 40, barWidth - 5, h);
  }

  fill(0);
  textSize(18);

  if (step == steps.size() - 1) {
    text("Sorting Complete!", 40, 195);
  } else if (playing) {
    text("Sorting...", 40, 195);
  } else {
    text("Paused", 40, 195);
  }

  textSize(14);
  text("Step: " + (step + 1) + " / " + steps.size(),
       40, 220);

  // 애니메이션 진행
  if (playing && step < steps.size() - 1) {
    step++;
  }
}

// 랜덤 배열 생성
void resetArray() {
  for (int i = 0; i < n; i++) {
    arr[i] = int(random(20, 100));
  }
}

// 정렬 시작
void startSort(int type) {

  steps.clear();
  step = 0;
  playing = true;

  int[] temp = arr.clone();

  saveStep(temp);

  if (type == 1) {
    sortName = "Bubble Sort";
    bubbleSort(temp);
  }
  else if (type == 2) {
    sortName = "Insertion Sort";
    insertionSort(temp);
  }
  else if (type == 3) {
    sortName = "Merge Sort";
    mergeSort(temp, 0, n - 1);
  }
  else if (type == 4) {
    sortName = "Quick Sort";
    quickSort(temp, 0, n - 1);
  }
  else if (type == 5) {
    sortName = "Heap Sort";
    heapSort(temp);
  }

  saveStep(temp);
}

// 현재 배열 저장
void saveStep(int[] a) {
  steps.add(a.clone());
}

// Bubble Sort
void bubbleSort(int[] a) {

  for (int i = 0; i < n - 1; i++) {
    for (int j = 0; j < n - i - 1; j++) {

      if (a[j] > a[j + 1]) {
        int temp = a[j];
        a[j] = a[j + 1];
        a[j + 1] = temp;

        saveStep(a);
      }
    }
  }
}

// Insertion Sort
void insertionSort(int[] a) {

  for (int i = 1; i < n; i++) {

    int key = a[i];
    int j = i - 1;

    while (j >= 0 && a[j] > key) {
      a[j + 1] = a[j];
      j--;

      saveStep(a);
    }

    a[j + 1] = key;
    saveStep(a);
  }
}

// Merge Sort
void mergeSort(int[] a, int left, int right) {

  if (left < right) {

    int mid = (left + right) / 2;

    mergeSort(a, left, mid);
    mergeSort(a, mid + 1, right);

    merge(a, left, mid, right);
  }
}

void merge(int[] a, int left, int mid, int right) {

  int[] temp = new int[right - left + 1];

  int i = left;
  int j = mid + 1;
  int k = 0;

  while (i <= mid && j <= right) {

    if (a[i] <= a[j]) {
      temp[k++] = a[i++];
    } else {
      temp[k++] = a[j++];
    }
  }

  while (i <= mid) {
    temp[k++] = a[i++];
  }

  while (j <= right) {
    temp[k++] = a[j++];
  }

  for (int x = 0; x < temp.length; x++) {
    a[left + x] = temp[x];
  }

  saveStep(a);
}

// Quick Sort
void quickSort(int[] a, int low, int high) {

  if (low < high) {

    int pi = partition(a, low, high);

    quickSort(a, low, pi - 1);
    quickSort(a, pi + 1, high);
  }
}

int partition(int[] a, int low, int high) {

  int pivot = a[high];
  int i = low - 1;

  for (int j = low; j < high; j++) {

    if (a[j] < pivot) {

      i++;

      int temp = a[i];
      a[i] = a[j];
      a[j] = temp;

      saveStep(a);
    }
  }

  int temp = a[i + 1];
  a[i + 1] = a[high];
  a[high] = temp;

  saveStep(a);

  return i + 1;
}

// Heap Sort
void heapSort(int[] a) {

  for (int i = n / 2 - 1; i >= 0; i--) {
    heapify(a, n, i);
  }

  for (int i = n - 1; i > 0; i--) {

    int temp = a[0];
    a[0] = a[i];
    a[i] = temp;

    saveStep(a);

    heapify(a, i, 0);
  }
}

void heapify(int[] a, int size, int root) {

  int largest = root;
  int left = 2 * root + 1;
  int right = 2 * root + 2;

  if (left < size && a[left] > a[largest]) {
    largest = left;
  }

  if (right < size && a[right] > a[largest]) {
    largest = right;
  }

  if (largest != root) {

    int temp = a[root];
    a[root] = a[largest];
    a[largest] = temp;

    saveStep(a);

    heapify(a, size, largest);
  }
}

// 키보드 입력
void keyPressed() {

  if (key == '1') {
    startSort(1);
  }
  else if (key == '2') {
    startSort(2);
  }
  else if (key == '3') {
    startSort(3);
  }
  else if (key == '4') {
    startSort(4);
  }
  else if (key == '5') {
    startSort(5);
  }
  else if (key == ' ') {
    playing = !playing;
  }
  else if (key == 'r' || key == 'R') {
    resetArray();
    startSort(1);
  }
}
