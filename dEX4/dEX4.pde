PFont Font1;
int asciiNum=65;
int number=0;
boolean lettersNotNum = true;
color c=ChangeColor();
int fontSize=200;
String[] word={"donglin"};

void setup() {
  size(800, 400);
  Font1 = createFont("Arial Bold", fontSize);
}

void draw() { 
  background(152,190,100);
  checkLimit();
  textFont(Font1);
  textAlign(CENTER);
  fill(c);

  if (lettersNotNum == true) {
    text(char(asciiNum),0.4*width, 0.5*height);
    text(char(asciiNum+32),0.6*width, 0.5*height);


  }
  if (lettersNotNum == false) {
    text(number, 0.5*width, 0.5*height);
    textSize(fontSize/2);
    text(word[number], 0.5*width, 0.2*height);//number as word
    for (int i=0; i<number; i++) {//Arrange circles
      if (i<5) {
        ellipse(0.5*width+60*(i-2), 0.6*height+50, 50, 50);
      } else {
        ellipse(0.5*width+60*(i-7), 0.7*height+50, 50, 50);
      }
    }
  }
}

void mousePressed() {
  asciiNum++;
  number++;
  c=ChangeColor();
}

color ChangeColor() {
  c=color(random(0, 255), random(0, 255), random(0, 255));
  return c;
}
void keyPressed() {
  if (key == 'n') {
    lettersNotNum=!lettersNotNum;
    number=0;
    asciiNum=65;
  }

  if (key == CODED) {
    if (keyCode == UP || keyCode == RIGHT) {
      asciiNum++;
      number++;
      c=ChangeColor();
    }
    if (keyCode == DOWN || keyCode == LEFT) {
      asciiNum--;
      number--;
      c=ChangeColor();
    }
  }
}

void checkLimit() {
  //Letters
  if (asciiNum>90) {
    asciiNum=65;
  }
  if (asciiNum<65) {
    asciiNum=90;
  }
  if (number>10) {
    number=0;
  }
  if (number<0) {
    number=10;
  }
}
