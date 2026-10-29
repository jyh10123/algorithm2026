import java.util.ArrayList;

int[] arr = new int[10];

ArrayList<int[]> steps = new ArrayList<int[]>();
ArrayList<Integer> pivots = new ArrayList<Integer>();

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
  saveStep(-1);

  // 퀵 정렬 실행
  quickSort(arr, 0, arr.length - 1);

  println("After Sorting:");
  printArray(arr);
}

void draw() {
  background(255);

  fill(0);
  textSize(26);
  text("Quick Sort Visualization", 220, 40);

  // 현재 단계 배열
  int[] current = steps.get(step);
  int pivotIndex = pivots.get(step);

  // 막대그래프 출력
  for (int i = 0; i < current.length; i++) {

    // 피벗 표시
    if (sorting && i == pivotIndex) {
      fill(255, 100, 100);
    } else if (!sorting) {
      fill(100, 200, 150);
    } else {
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

// 퀵 정렬
void quickSort(int[] a, int low, int high) {

  if (low < high) {

    // 피벗 위치 결정
    int pi = partition(a, low, high);

    // 왼쪽 정렬
    quickSort(a, low, pi - 1);

    // 오른쪽 정렬
    quickSort(a, pi + 1, high);
  }
}

// 분할 함수
int partition(int[] a, int low, int high) {

  // 마지막 원소를 피벗으로 선택
  int pivot = a[high];

  int i = low - 1;

  // 피벗 저장
  saveStep(high);

  for (int j = low; j < high; j++) {

    if (a[j] < pivot) {

      i++;

      // 두 원소 교환
      int temp = a[i];
      a[i] = a[j];
      a[j] = temp;

      // 현재 상태 저장
      saveStep(high);
    }
  }

  // 피벗을 올바른 위치로 이동
  int temp = a[i + 1];
  a[i + 1] = a[high];
  a[high] = temp;

  // 피벗 위치 저장
  saveStep(i + 1);

  return i + 1;
}

// 현재 배열 상태 저장
void saveStep(int pivotIndex) {
  steps.add(arr.clone());
  pivots.add(pivotIndex);
}

// R키를 누르면 다시 정렬
void keyPressed() {

  if (key == 'r' || key == 'R') {

    steps.clear();
    pivots.clear();

    // 새로운 랜덤 숫자 생성
    for (int i = 0; i < arr.length; i++) {
      arr[i] = int(random(20, 100));
    }

    println("Before Sorting:");
    printArray(arr);

    saveStep(-1);

    quickSort(arr, 0, arr.length - 1);

    println("After Sorting:");
    printArray(arr);

    step = 0;
    sorting = true;
  }
}
