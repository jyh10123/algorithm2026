int Value[][] = new int[3][101];
int DP[][] = new int[5][101];
int cnt = 8;

int pat[][] = {
  {1, 0, 0},
  {0, 1, 0},
  {0, 0, 1},
  {1, 0, 1},
  {0, 0, 0}
};

int parent[][] = new int[5][101];
int result[] = new int[101];

int step = 0;
int maxScore = 0;
boolean finished = false;

int cellSize = 65;
int startX = 100;
int startY = 130;

int lastTime = 0;
int speed = 700;

// 패턴 점수 계산
int score(int p, int j) {
  int s = 0;

  for (int r = 0; r < 3; r++)
    if (pat[p][r] == 1)
      s += Value[r][j];

  return s;
}

// 인접 패턴 검사
boolean ok(int p, int q) {
  for (int r = 0; r < 3; r++)
    if (pat[p][r] == 1 && pat[q][r] == 1)
      return false;

  return true;
}

void setup() {
  size(850, 550);
  textAlign(CENTER, CENTER);
  initialize();
}

void initialize() {
  int i, j, p;

  println("Pebble Placement Problem");
  println("------------------------");

  for (i = 0; i < 3; i++) {
    for (j = 0; j < cnt; j++) {
      Value[i][j] = (int)random(-10, 10);
      print(nf(Value[i][j], 4) + " ");
    }
    println();
  }

  for (p = 0; p < 5; p++) {
    DP[p][0] = score(p, 0);
    parent[p][0] = -1;
  }

  for (j = 1; j < cnt; j++) {
    for (p = 0; p < 5; p++) {

      int best = -999999;
      int bestPattern = -1;

      for (int q = 0; q < 5; q++) {
        if (ok(p, q) && DP[q][j-1] > best) {
          best = DP[q][j-1];
          bestPattern = q;
        }
      }

      DP[p][j] = best + score(p, j);
      parent[p][j] = bestPattern;
    }
  }

  maxScore = -999999;
  int bestPattern = -1;

  for (p = 0; p < 5; p++) {
    if (DP[p][cnt-1] > maxScore) {
      maxScore = DP[p][cnt-1];
      bestPattern = p;
    }
  }

  for (j = cnt-1; j >= 0; j--) {
    result[j] = bestPattern;
    bestPattern = parent[bestPattern][j];
  }

  println("------------------------");
  println("max = " + maxScore);

  step = 0;
  finished = false;
  lastTime = millis();
}

void draw() {
  background(245);

  fill(30);
  textSize(25);
  text("Pebble Placement Problem", width/2, 45);

  textSize(15);
  text("Dynamic Programming", width/2, 80);

  // 격자 출력
  for (int j = 0; j < cnt; j++) {
    for (int i = 0; i < 3; i++) {

      int x = startX + j * cellSize;
      int y = startY + i * cellSize;

      if (j < step && pat[result[j]][i] == 1) {
        fill(100, 200, 120);
      } else if (j == step && !finished) {
        fill(255, 220, 130);
      } else {
        fill(255);
      }

      stroke(100);
      rect(x, y, cellSize, cellSize);

      fill(0);
      textSize(17);
      text(Value[i][j], x + cellSize/2, y + cellSize/2);

      // 조약돌 표시
      if (j < step && pat[result[j]][i] == 1) {
        noFill();
        stroke(30, 80, 200);
        strokeWeight(3);
        ellipse(x + cellSize/2, y + cellSize/2, 45, 45);
        strokeWeight(1);
      }
    }
  }

  fill(40);
  textSize(18);

  if (!finished) {
    text("Placing Pebbles... Step : " + step,
         width/2, 380);
  } else {
    fill(0, 140, 60);
    text("Maximum Score = " + maxScore,
         width/2, 380);
  }

  fill(70);
  textSize(15);
  text("Green : Selected Pebbles", width/2, 420);
  text("R : Random Restart", width/2, 455);
  text("SPACE : Replay", width/2, 485);

  if (!finished && millis() - lastTime > speed) {
    step++;
    lastTime = millis();

    if (step >= cnt) {
      finished = true;
    }
  }
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    initialize();
  }

  if (key == ' ') {
    step = 0;
    finished = false;
    lastTime = millis();
  }
}
