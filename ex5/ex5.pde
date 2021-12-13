import ddf.minim.*;
Minim       minim;
AudioPlayer music;
float voice;
void setup() {
  size(640, 720, P3D);
  colorMode(HSB, 100, 100, 100, 100);
  minim = new Minim(this);
   music = minim.loadFile("song.mp3",1024);
  music.loop();  
  frameRate(60);
}
 
void draw() {    
  voice = music. mix. level();
  
  noStroke();
  
  background(0);
 
  translate(width/2, height/2, -300);
  scale(voice*2);
    
  int rot = frameCount;

  rotateZ(radians(90));
  rotateX(radians(rot/60.0f * 10));
  rotateY(radians(rot/60.0f * 30));
 
  blendMode(ADD);
    
  for (int i = 0; i < 100; i++) {
    fill(map(i % 10, 0, 10, 0, 100), 100, 100, 30);
 
    beginShape(TRIANGLES);
    vertex(200, 50, -50);
    vertex(100, 100, 50);
    vertex(100, 0, 20);
    endShape();
 
    rotateY(radians(270.0f/100));
  }
    
  //endRaw();
  
  if (frameCount % 30 == 0) println(frameRate);
}  
