int[] list, tlist;
int len=16, max=100;
String[] titles = {"selectionSort", "bubbleSort", "insertSort", "mergeSort", "quickSort"};

void setup() {
  int type = 0;
  list = new int[len];
  for (int i=0; i<len; i++)
    list[i] = (int)random(max);
  printList();
  run(type);
  printList();
}

void draw() {
}

void printList() {
  for(int i=0; i<len; i++)
    print(nf(list[i],3)+' ');
  println();  
}

void run(int type) {
  if (type==0) selectionSort();
  else if (type==1) bubbleSort();
  else if (type==2) insertSort();
  else if (type==3) mergeSort();
  else if (type==4) quickSort();  
}

void selectionSort() {
  int i;
  for (i=0; i<len; i++) {
  }
  println("selectionSort...");
}
