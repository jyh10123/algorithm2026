import java.util.LinkedList;
import java.util.Queue;
import java.util.Stack;
import java.util.ArrayList;

int n = 7;

String[] names = {
  "A", "B", "C", "D", "E", "F", "G"
};

int[][] graph = {
  {0, 1, 1, 0, 0, 0, 0},
  {1, 0, 0, 1, 1, 0, 0},
  {1, 0, 0, 0, 0, 1, 1},
  {0, 1, 0, 0, 0, 0, 0},
  {0, 1, 0, 0, 0, 0, 0},
  {0, 0, 1, 0, 0, 0, 0},
  {0, 0, 1, 0, 0, 0, 0}
};

float[] x = {450, 250, 650, 150, 350, 550, 750};
float[] y = {130, 250, 250, 380, 380, 380, 380};

boolean[] visited = new boolean[n];

ArrayList<Integer> order = new ArrayList<Integer>();

String mode = "BFS";

int step = 0;
int lastTime = 0;

boolean running = false;

void setup() {
  size(900, 600);
  textAlign(CENTER, CENTER);
}

void draw() {
  background(245);

  fill(0);
  textSize(30);
  text("BFS and DFS for a Graph", width/2, 40);

  textSize(22);
  text("Mode: " + mode, width/2, 80);

  // 탐색 애니메이션
  if (running && millis() - lastTime >= 800) {
    if (step < order.size()) {
      visited[order.get(step)] = true;
      step++;
      lastTime = millis();
    } else {
      running = false;
    }
  }

  drawEdges();
  drawNodes();
  drawOrder();

  fill(0);
  textSize(17);
  text("B: BFS   D: DFS   R: Reset",
       width/2, 560);
}

// 간선 그리기
void drawEdges() {
  stroke(120);
  strokeWeight(3);

  for (int i = 0; i < n; i++) {
    for (int j = i+1; j < n; j++) {
      if (graph[i][j] == 1) {
        line(x[i], y[i], x[j], y[j]);
      }
    }
  }
}

// 정점 그리기
void drawNodes() {
  for (int i = 0; i < n; i++) {

    stroke(80);
    strokeWeight(2);

    if (step > 0 && order.get(step-1) == i) {
      fill(255, 190, 80);
    } else if (visited[i]) {
      fill(100, 200, 130);
    } else {
      fill(255);
    }

    ellipse(x[i], y[i], 65, 65);

    fill(0);
    textSize(24);
    text(names[i], x[i], y[i]);
  }
}

// BFS: 큐 사용
void bfs(int start) {
  Queue<Integer> queue = new LinkedList<Integer>();
  boolean[] check = new boolean[n];

  queue.add(start);
  check[start] = true;

  while (!queue.isEmpty()) {
    int current = queue.poll();

    order.add(current);

    for (int i = 0; i < n; i++) {
      if (graph[current][i] == 1 && !check[i]) {
        queue.add(i);
        check[i] = true;
      }
    }
  }
}

// DFS: 스택 사용
void dfs(int start) {
  Stack<Integer> stack = new Stack<Integer>();
  boolean[] check = new boolean[n];

  stack.push(start);

  while (!stack.empty()) {
    int current = stack.pop();

    if (check[current]) continue;

    check[current] = true;
    order.add(current);

    for (int i = n-1; i >= 0; i--) {
      if (graph[current][i] == 1 && !check[i]) {
        stack.push(i);
      }
    }
  }
}

// 탐색 순서 출력
void drawOrder() {
  String result = "";

  for (int i = 0; i < step; i++) {
    result += names[order.get(i)];

    if (i < step-1) {
      result += " -> ";
    }
  }

  fill(0);
  textSize(22);
  text("Visit Order", width/2, 460);
  text(result, width/2, 500);
}

// 초기화
void reset() {
  visited = new boolean[n];
  order.clear();

  step = 0;
  running = false;
}

// 키보드 입력
void keyPressed() {
  if (key == 'b' || key == 'B') {
    reset();
    mode = "BFS";
    bfs(0);
    running = true;
    lastTime = millis();
  }

  if (key == 'd' || key == 'D') {
    reset();
    mode = "DFS";
    dfs(0);
    running = true;
    lastTime = millis();
  }

  if (key == 'r' || key == 'R') {
    reset();
  }
}
