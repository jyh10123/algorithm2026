import java.util.Stack;

String infix = "";
String postfix = "";
String result = "";

boolean calculated = false;

// 화면 설정
void setup() {
  size(750, 400);
  textSize(20);
}

// 화면 출력
void draw() {
  background(245);

  fill(0);
  textSize(26);
  text("Infix to Postfix Calculator", 40, 50);

  textSize(16);
  text("Enter an expression and press ENTER", 40, 90);

  // 입력창
  fill(255);
  stroke(0);
  rect(40, 110, 670, 50);

  fill(0);
  textSize(22);
  text(infix, 50, 143);

  // 결과 출력
  textSize(20);
  text("Infix: " + infix, 40, 210);

  if (calculated) {
    text("Postfix: " + postfix, 40, 260);
    text("Result: " + result, 40, 310);
  }

  textSize(14);
  fill(100);
  text("ENTER: Calculate     BACKSPACE: Delete     C: Clear", 40, 370);
}

// 키보드 입력
void keyPressed() {

  // Enter 누르면 계산
  if (key == ENTER || key == RETURN) {
    try {
      postfix = infixToPostfix(infix);
      float value = evaluatePostfix(postfix);
      result = str(value);
    }
    catch (Exception e) {
      postfix = "";
      result = "Error: " + e.getMessage();
    }

    calculated = true;
  }

  // Backspace 누르면 마지막 글자 삭제
  else if (key == BACKSPACE) {
    if (infix.length() > 0) {
      infix = infix.substring(0, infix.length() - 1);
    }
    calculated = false;
  }

  // C 누르면 초기화
  else if (key == 'c' || key == 'C') {
    infix = "";
    postfix = "";
    result = "";
    calculated = false;
  }

  // 수식 입력
  else if ((key >= '0' && key <= '9') ||
           key == '+' || key == '-' ||
           key == '*' || key == '/' ||
           key == '(' || key == ')' ||
           key == ' ') {

    infix += key;
    calculated = false;
  }
}

// 연산자 우선순위
int priority(char op) {
  if (op == '+' || op == '-') return 1;
  if (op == '*' || op == '/') return 2;
  return 0;
}

// 중위 표기식 -> 후위 표기식
String infixToPostfix(String infix) {

  Stack<Character> stack = new Stack<Character>();
  String postfix = "";

  for (int i = 0; i < infix.length(); i++) {

    char ch = infix.charAt(i);

    if (ch == ' ') {
      continue;
    }

    // 숫자 처리
    if (Character.isDigit(ch)) {

      while (i < infix.length() &&
             Character.isDigit(infix.charAt(i))) {

        postfix += infix.charAt(i);
        i++;
      }

      postfix += " ";
      i--;
    }

    // 여는 괄호
    else if (ch == '(') {
      stack.push(ch);
    }

    // 닫는 괄호
    else if (ch == ')') {

      while (!stack.empty() && stack.peek() != '(') {
        postfix += stack.pop() + " ";
      }

      if (stack.empty()) {
        throw new RuntimeException("Invalid parentheses");
      }

      stack.pop();
    }

    // 연산자
    else if (ch == '+' || ch == '-' ||
             ch == '*' || ch == '/') {

      while (!stack.empty() &&
             stack.peek() != '(' &&
             priority(stack.peek()) >= priority(ch)) {

        postfix += stack.pop() + " ";
      }

      stack.push(ch);
    }
  }

  // 남은 연산자 처리
  while (!stack.empty()) {

    if (stack.peek() == '(') {
      throw new RuntimeException("Invalid parentheses");
    }

    postfix += stack.pop() + " ";
  }

  return postfix.trim();
}

// 후위 표기식 계산
float evaluatePostfix(String postfix) {

  Stack<Float> stack = new Stack<Float>();

  String[] tokens = splitTokens(postfix, " ");

  for (String token : tokens) {

    // 숫자
    if (token.matches("\\d+")) {
      stack.push(float(token));
    }

    // 연산자
    else {

      if (stack.size() < 2) {
        throw new RuntimeException("Invalid expression");
      }

      float b = stack.pop();
      float a = stack.pop();

      if (token.equals("+")) {
        stack.push(a + b);
      }
      else if (token.equals("-")) {
        stack.push(a - b);
      }
      else if (token.equals("*")) {
        stack.push(a * b);
      }
      else if (token.equals("/")) {

        if (b == 0) {
          throw new RuntimeException("Division by zero");
        }

        stack.push(a / b);
      }
    }
  }

  if (stack.size() != 1) {
    throw new RuntimeException("Invalid expression");
  }

  return stack.pop();
}
