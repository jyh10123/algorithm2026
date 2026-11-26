import java.util.ArrayList;
import java.util.Collections;

int n = 6;

String[] names = {"A", "B", "C", "D", "E", "F"};

float[] x = {150, 450, 750, 150, 450, 750};
float[] y = {150, 110, 150, 380, 420, 380};

ArrayList<Edge> edges = new ArrayList<Edge>();

int[] parent = new int[n];

int step = 0;
int total = 0;
int selected = 0;
int lastTime = 0;

boolean running = false;

String message = "Press SPACE to start";

// 간선 클래스
class Edge implements Comparable<Edge> {
  int u, v, weight;
  int state = 0;

  Edge(int u, int v, int weight) {
    this.u = u;
    this.v = v;
    this.weight = weight;
  }

  public int compareTo(Edge other) {
    return Integer.compare(weight, other.weight);
  }
}

void setup() {
  size(900, 650);
  textAlign(CENTER, CENTER);

  edges.add(new Edge(0, 1, 4));
  edges.add(new Edge(0, 3, 2));
  edges.add(new Edge(1, 2, 6));
  edges.add(new Edge(1, 3, 3));
  edges.add(new Edge(1, 4, 5));
  edges.add(new Edge(2, 4, 1));
  edges.add(new Edge(2, 5, 7));
  edges.add(new Edge(3, 4, 8));
  edges.add(new Edge(4, 5, 9));

  // 가중치 기준 오름차순 정렬
  Collections.sort(edges);

  reset();
}

void draw() {
  background(245);

  fill(0);
  textSize(30);
  text("Kruskal's Algorithm", width/2, 35);

  // 일정 시간마다 간선 검사
  if (running && millis() - lastTime >= 1000) {
    kruskalStep();
    lastTime = millis();
  }

  drawEdges();
  drawNodes();

  fill(0);
  textSize(23);
  text("Total Weight: " + total, width/2, 490);
  text("Selected Edges: " + selected + " / " + (n-1),
       width/2, 525);

  textSize(20);
  text(message, width/2, 565);

  textSize(16);
  text("SPACE: Start / N: Next / R: Reset",
       width/2, 620);
}

// Union-Find: 대표 정점 찾기
int find(int v) {
  if (parent[v] != v) {
    parent[v] = find(parent[v]);
  }

  return parent[v];
}

// 두 집합 합치기
void union(int a, int b) {
  int rootA = find(a);
  int rootB = find(b);

  parent[rootB] = rootA;
}

// 크루스칼 알고리즘 한 단계 실행
void kruskalStep() {
  if (selected == n-1 || step >= edges.size()) {
    running = false;
    return;
  }

  Edge e = edges.get(step);
  step++;

  // 사이클 검사
  if (find(e.u) != find(e.v)) {
    union(e.u, e.v);

    e.state = 1;
    total += e.weight;
    selected++;

    message = names[e.u] + " - " + names[e.v]
              + " : Selected";
  } else {
    e.state = 2;

    message = names[e.u] + " - " + names[e.v]
              + " : Cycle detected";
  }

  // 최소 신장 트리 완성
  if (selected == n-1) {
    running = false;
    message = "Minimum Spanning Tree Completed!";
  } else if (step >= edges.size()) {
    running = false;
    message = "Graph is disconnected";
  }
}

// 간선 그리기
void drawEdges() {
  for (Edge e : edges) {

    if (e.state == 1) {
      stroke(30, 170, 80);
      strokeWeight(5);
    } else if (e.state == 2) {
      stroke(220, 70, 70);
      strokeWeight(3);
    } else {
      stroke(160);
      strokeWeight(2);
    }

    line(x[e.u], y[e.u], x[e.v], y[e.v]);

    float mx = (x[e.u] + x[e.v]) / 2;
    float my = (y[e.u] + y[e.v]) / 2;

    noStroke();
    fill(245);
    rectMode(CENTER);
    rect(mx, my, 35, 30);

    fill(0);
    textSize(21);
    text(e.weight, mx, my);
  }
}

// 정점 그리기
void drawNodes() {
  for (int i = 0; i < n; i++) {
    stroke(80);
    strokeWeight(2);
    fill(255);

    ellipse(x[i], y[i], 65, 65);

    fill(0);
    textSize(25);
    text(names[i], x[i], y[i]);
  }
}

// 초기화
void reset() {
  step = 0;
  total = 0;
  selected = 0;
  running = false;

  for (int i = 0; i < n; i++) {
    parent[i] = i;
  }

  for (Edge e : edges) {
    e.state = 0;
  }

  message = "Press SPACE to start";
}

// 키보드 입력
void keyPressed() {
  if (key == ' ' && selected < n-1) {
    running = true;
    lastTime = millis();
  }

  if (key == 'n' || key == 'N') {
    running = false;
    kruskalStep();
  }

  if (key == 'r' || key == 'R') {
    reset();
  }
}
