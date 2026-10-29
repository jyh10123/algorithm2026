import java.util.ArrayList;

int[] arr = new int[10];

ArrayList<int[]> steps = new ArrayList<int[]>();
ArrayList<Integer> highlights = new ArrayList<Integer>();
ArrayList<Integer> sortedSizes = new ArrayList<Integer>();

int step = 0;
boolean sorting = true;

void setup() {
  size(800, 500);
  frameRate(3);

  // 랜덤 숫자 생성
  for (int i = 0; i < arr.length; i++) {
    arr[i] = int(random(20, 100));
  }

  println("Before Sorting:");
  printArray(arr);

  // 초기 배열 저장
  saveStep(-1, arr.length);

  // 힙 정렬 실행
  heapSort(arr);

  println("After Sorting:");
  printArray(arr);
}

void draw() {
  background(255);

  fill(0);
  textSize(26);
  text("Heap Sort Visualization", 220, 40);

  // 현재 단계 배열
  int[] current = steps.get(step);
  int highlight = highlights.get(step);
  int heapSize = sortedSizes.get(step);

  // 막대그래프 출력
  for (int i = 0; i < current.length; i++) {

    // 정렬 완료된 영역
    if (i >= heapSize) {
      fill(100, 200, 150);
    }
    // 현재 비교 또는 교환하는 원소
    else if (i == highlight) {
      fill(255, 100, 100);
    }
    // 정렬 진행 중
    else {
      fill(100, 150, 255);
    }

    rect(40 + i * 72,
         height - current[i] * 3 - 50,
         50,
         current[i] * 3);

    fill(0);
    textSize(16);
    text(current[i], 50 + i * 72, height - 25);
  }

  // 상태 표시
  fill(0);
  textSize(18);

  if (sorting) {
    text("Sorting...", 40, 80);
  } else {
    text("Sorting Complete!", 40, 80);
  }

  textSize(14);
  text("Step: " + (step + 1) + " / " + steps.size(), 40, 110);
  text("Press R to Restart", 40, 135);

  // 애니메이션 진행
  if (sorting) {
    if (step < steps.size() - 1) {
      step++;
    } else {
      sorting = false;
    }
  }
}

// 힙 정렬
void heapSort(int[] a) {

  int n = a.length;

  // 최대 힙 생성
  for (int i = n / 2 - 1; i >= 0; i--) {
    heapify(a, n, i);
  }

  // 가장 큰 값을 뒤로 이동
  for (int i = n - 1; i > 0; i--) {

    // 루트와 마지막 원소 교환
    int temp = a[0];
    a[0] = a[i];
    a[i] = temp;

    // 정렬된 영역 저장
    saveStep(0, i);

    // 남은 원소로 최대 힙 재구성
    heapify(a, i, 0);
  }

  // 전체 정렬 완료
  saveStep(-1, 0);
}

// 최대 힙 구성
void heapify(int[] a, int n, int i) {

  int largest = i;

  int left = 2 * i + 1;
  int right = 2 * i + 2;

  // 왼쪽 자식 비교
  if (left < n && a[left] > a[largest]) {
    largest = left;
  }

  // 오른쪽 자식 비교
  if (right < n && a[right] > a[largest]) {
    largest = right;
  }

  // 부모보다 큰 자식이 있으면 교환
  if (largest != i) {

    int temp = a[i];
    a[i] = a[largest];
    a[largest] = temp;

    // 현재 배열 상태 저장
    saveStep(largest, n);

    // 재귀적으로 힙 구성
    heapify(a, n, largest);
  }
}

// 현재 배열 상태 저장
void saveStep(int highlight, int heapSize) {
  steps.add(arr.clone());
  highlights.add(highlight);
  sortedSizes.add(heapSize);
}

// R키를 누르면 다시 정렬
void keyPressed() {

  if (key == 'r' || key == 'R') {

    steps.clear();
    highlights.clear();
    sortedSizes.clear();

    // 새로운 랜덤 숫자 생성
    for (int i = 0; i < arr.length; i++) {
      arr[i] = int(random(20, 100));
    }

    println("Before Sorting:");
    printArray(arr);

    saveStep(-1, arr.length);

    heapSort(arr);

    println("After Sorting:");
    printArray(arr);

    step = 0;
    sorting = true;
  }
}
