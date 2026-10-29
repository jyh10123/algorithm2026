// Binary Search Tree Visualization

class Node {
  int value;
  Node left;
  Node right;

  Node(int value) {
    this.value = value;
    left = null;
    right = null;
  }
}

Node root = null;

String input = "";
String message = "Enter a number and press ENTER";
String traversal = "";

int highlightedValue = -1;

void setup() {
  size(1000, 650);
  textAlign(CENTER, CENTER);
  textSize(18);
}

void draw() {
  background(245);

  // 제목
  fill(0);
  textSize(30);
  text("Binary Search Tree Visualization", width / 2, 35);

  // 사용 방법
  textSize(15);
  text("ENTER: Insert   S: Search   D: Delete   I: Inorder   R: Reset",
       width / 2, 80);

  // 입력창
  fill(255);
  stroke(0);
  rect(350, 110, 300, 45, 8);

  fill(0);
  textSize(20);
  text("Input: " + input, width / 2, 132);

  // 메시지
  textSize(17);
  fill(50);
  text(message, width / 2, 185);

  // 트리 출력
  if (root != null) {
    drawTree(root, width / 2, 260, 220);
  }

  // 순회 결과
  fill(0);
  textSize(16);
  text("Inorder: " + traversal, width / 2, 610);
}

// 트리 그리기
void drawTree(Node node, float x, float y, float offset) {

  if (node == null) return;

  // 왼쪽 자식 연결
  if (node.left != null) {
    stroke(100);
    strokeWeight(2);

    line(x, y, x - offset, y + 85);

    drawTree(node.left, x - offset, y + 85, offset / 2);
  }

  // 오른쪽 자식 연결
  if (node.right != null) {
    stroke(100);
    strokeWeight(2);

    line(x, y, x + offset, y + 85);

    drawTree(node.right, x + offset, y + 85, offset / 2);
  }

  // 노드 색상
  if (node.value == highlightedValue) {
    fill(255, 100, 100);
  } else {
    fill(100, 150, 255);
  }

  stroke(0);
  strokeWeight(1);
  ellipse(x, y, 50, 50);

  fill(255);
  textSize(18);
  text(node.value, x, y);
}

// 노드 삽입
Node insert(Node node, int value) {

  if (node == null) {
    return new Node(value);
  }

  if (value < node.value) {
    node.left = insert(node.left, value);
  }
  else if (value > node.value) {
    node.right = insert(node.right, value);
  }

  return node;
}

// 노드 검색
boolean search(Node node, int value) {

  if (node == null) {
    return false;
  }

  if (node.value == value) {
    return true;
  }

  if (value < node.value) {
    return search(node.left, value);
  } else {
    return search(node.right, value);
  }
}

// 노드 삭제
Node delete(Node node, int value) {

  if (node == null) {
    return null;
  }

  if (value < node.value) {
    node.left = delete(node.left, value);
  }
  else if (value > node.value) {
    node.right = delete(node.right, value);
  }
  else {

    // 자식이 없는 경우 또는 하나인 경우
    if (node.left == null) {
      return node.right;
    }

    if (node.right == null) {
      return node.left;
    }

    // 자식이 두 개인 경우
    Node temp = findMin(node.right);

    node.value = temp.value;

    node.right = delete(node.right, temp.value);
  }

  return node;
}

// 최솟값 찾기
Node findMin(Node node) {

  while (node.left != null) {
    node = node.left;
  }

  return node;
}

// 중위 순회
void inorder(Node node) {

  if (node != null) {
    inorder(node.left);
    traversal += node.value + " ";
    inorder(node.right);
  }
}

// 키보드 입력
void keyPressed() {

  // 숫자 입력
  if (key >= '0' && key <= '9') {
    input += key;
  }

  // Backspace
  else if (key == BACKSPACE) {
    if (input.length() > 0) {
      input = input.substring(0, input.length() - 1);
    }
  }

  // Enter: 삽입
  else if (key == ENTER || key == RETURN) {

    if (input.length() > 0) {

      int value = int(input);

      if (!search(root, value)) {
        root = insert(root, value);
        message = "Inserted: " + value;
      } else {
        message = "Value already exists: " + value;
      }

      highlightedValue = value;
      input = "";

      traversal = "";
      inorder(root);
    }
  }

  // S: 검색
  else if (key == 's' || key == 'S') {

    if (input.length() > 0) {

      int value = int(input);

      if (search(root, value)) {
        message = "Found: " + value;
        highlightedValue = value;
      } else {
        message = "Not Found: " + value;
        highlightedValue = -1;
      }

      input = "";
    }
  }

  // D: 삭제
  else if (key == 'd' || key == 'D') {

    if (input.length() > 0) {

      int value = int(input);

      if (search(root, value)) {
        root = delete(root, value);
        message = "Deleted: " + value;
      } else {
        message = "Value not found: " + value;
      }

      highlightedValue = -1;
      input = "";

      traversal = "";
      inorder(root);
    }
  }

  // I: 중위 순회
  else if (key == 'i' || key == 'I') {

    traversal = "";
    inorder(root);

    message = "Inorder Traversal";
  }

  // R: 초기화
  else if (key == 'r' || key == 'R') {

    root = null;
    input = "";
    traversal = "";
    highlightedValue = -1;

    message = "Tree Reset!";
  }
}
