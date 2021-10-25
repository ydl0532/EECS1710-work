
PImage img01;
int i;
int x = 100;
int y = 210;
int s = 100;
int speed = 1;
void setup(){
  size(650,411,P2D);

}
void draw(){
    stroke( 255, 255, 124 ,255); 
    strokeWeight( 5 );
  img01 = loadImage("01.jpg");
  image(img01,0,0);
 
  for(i=0; i<10;i++){
   rect(x-100,210 - (i-s),s,s-80);
   fill(120,0,0);

   }
  x += speed;
  ellipse(x-30,y+125,s-90,s-90);
   fill(120,0,0);
  ellipse(x-70,y+125,s-90,s-90);
   if(x > width || x< 0+99){
   speed *= -1;
   
   }
 

}
