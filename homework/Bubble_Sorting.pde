int[] arr = new int[10];

int i = 0;
int j = 0;

boolean sorting = true;

void setup() {
  size(800, 500);
  frameRate(3);

  // 랜덤 숫자 생성
  for (int k = 0; k < arr.length; k++) {
    arr[k] = int(random(20, 100));
  }

  println("Before Sorting:");
  printArray(arr);
}

void draw() {
  background(255);

  fill(0);
  textSize(26);
  text("Bubble Sort Visualization", 230, 40);

  // 막대그래프 출력
  for (int k = 0; k < arr.length; k++) {

    if (sorting && (k == j || k == j + 1)) {
      fill(255, 100, 100);
    } else {
      fill(100, 150, 255);
    }

    rect(40 + k * 72, height - arr[k] * 3 - 50,
         50, arr[k] * 3);

    fill(0);
    textSize(16);
    text(arr[k], 50 + k * 72, height - 25);
  }

  // 버블 정렬
  if (sorting) {

    if (j < arr.length - i - 1) {

      if (arr[j] > arr[j + 1]) {

        int temp = arr[j];
        arr[j] = arr[j + 1];
        arr[j + 1] = temp;
      }

      j++;

    } else {

      j = 0;
      i++;

      if (i >= arr.length - 1) {
        sorting = false;

        println("After Sorting:");
        printArray(arr);
      }
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
  text("Press R to Restart", 40, 110);
}

// R키를 누르면 다시 정렬
void keyPressed() {

  if (key == 'r' || key == 'R') {

    for (int k = 0; k < arr.length; k++) {
      arr[k] = int(random(20, 100));
    }

    i = 0;
    j = 0;
    sorting = true;

    println("Before Sorting:");
    printArray(arr);
  }
}
