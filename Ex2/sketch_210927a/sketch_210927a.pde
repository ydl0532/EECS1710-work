PImage img01;
float x = 90;
float r = 180;
float u = 160;
float t = 95;
float s = 50;
float speed = 4;

void setup() {
size(600,600,P2D);
img01 = loadImage("01.jpg");
img01.resize(600,600);
}
void draw(){
  background(img01);
  move();
  display();
  fill(255,255,0);
   ellipse(mouseX,mouseY,30,30);
}
void move(){
 x= x + speed;
 if (x>width){
   x=0;}
 r=r + speed;
 if (r>width){
   r=0;}
  t= t + speed;
 if (t>width){
   t=0; }
 u = u + speed;
 if (u>width){
   u=0;}   
}
 void display(){
 fill(250,0,0);
 rect(x,426,95,25);
 rect(t,416,40,10);
 fill(0);
 ellipse(x,460,15,15);
 ellipse(r,460,15,15);
 rect(u,400,25,25);
 }
