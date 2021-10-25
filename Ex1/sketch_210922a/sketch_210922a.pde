PImage img1;
PImage img2;
float X=0;

void setup(){
size(491,526);
background(255);
img1= loadImage("01.png"); 
frameRate(90);

img2= loadImage("02.png");
  image(img1,0,0,width,height);
}
void draw(){
  imageMode(CENTER);
  image(img2,mouseX,mouseY,5,5);
  frameRate(255);

}
 
  
