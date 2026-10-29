import java.util.ArrayList;

int[] arr = new int[10];
ArrayList<int[]> steps = new ArrayList<int[]>();

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
  steps.add(arr.clone());

  // 병합 정렬 실행 및 과정 저장
  mergeSort(arr, 0, arr.length - 1);

  println("After Sorting:");
  printArray(arr);
}

void draw() {
  background(255);

  fill(0);
  textSize(26);
  text("Merge Sort Visualization", 220, 40);

  // 현재 단계의 배열
  int[] current = steps.get(step);

  // 막대그래프 출력
  for (int i = 0; i < current.length; i++) {

    if (sorting) {
      fill(100, 150, 255);
    } else {
      fill(100, 200, 150);
    }

    rect(40 + i * 72,
         height - current[i] * 3 - 50,
         50,
         current[i] * 3);

    fill(0);
    textSize(16);
    text(current[i], 50 + i * 72, height - 25);
  }

  // 정렬 단계 진행
  if (sorting) {
    if (step < steps.size() - 1) {
      step++;
    } else {
      sorting = false;
    }
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
}

// 병합 정렬
void mergeSort(int[] a, int left, int right) {

  if (left < right) {

    int mid = (left + right) / 2;

    // 왼쪽 분할
    mergeSort(a, left, mid);

    // 오른쪽 분할
    mergeSort(a, mid + 1, right);

    // 병합
    merge(a, left, mid, right);
  }
}

// 두 배열 병합
void merge(int[] a, int left, int mid, int right) {

  int n1 = mid - left + 1;
  int n2 = right - mid;

  int[] L = new int[n1];
  int[] R = new int[n2];

  // 왼쪽 배열 복사
  for (int i = 0; i < n1; i++) {
    L[i] = a[left + i];
  }

  // 오른쪽 배열 복사
  for (int j = 0; j < n2; j++) {
    R[j] = a[mid + 1 + j];
  }

  int i = 0;
  int j = 0;
  int k = left;

  // 정렬하면서 병합
  while (i < n1 && j < n2) {

    if (L[i] <= R[j]) {
      a[k] = L[i];
      i++;
    } else {
      a[k] = R[j];
      j++;
    }

    k++;
  }

  // 왼쪽 배열에 남은 원소 복사
  while (i < n1) {
    a[k] = L[i];
    i++;
    k++;
  }

  // 오른쪽 배열에 남은 원소 복사
  while (j < n2) {
    a[k] = R[j];
    j++;
    k++;
  }

  // 병합 완료된 배열 상태 저장
  steps.add(a.clone());
}

// R키를 누르면 다시 정렬
void keyPressed() {

  if (key == 'r' || key == 'R') {

    steps.clear();

    for (int i = 0; i < arr.length; i++) {
      arr[i] = int(random(20, 100));
    }

    println("Before Sorting:");
    printArray(arr);

    steps.add(arr.clone());

    mergeSort(arr, 0, arr.length - 1);

    println("After Sorting:");
    printArray(arr);

    step = 0;
    sorting = true;
  }
}
