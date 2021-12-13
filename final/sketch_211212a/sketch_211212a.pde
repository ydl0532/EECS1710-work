
import ddf.minim.*;
Minim       minim;
AudioPlayer music;
float voice;
float n   = 7;
float t = 0;
int vr=9;

void setup()
        {
            size(400, 400,P2D);
            background( 0 );
            colorMode( HSB, vr, 1, 1,1 );
            minim = new Minim(this);
            music = minim.loadFile("song.mp3",1024);
            music.loop();
        }
void draw(){
            ellipse(mouseX,mouseY,voice*40,voice*40);
            voice = music. mix. level();//music number
            fill(0,0.008);
            rect(0,0,400,400);
            rect(0,0,400,400);
            noFill();        
            curve(voice*1.4);
            curve(voice*0.5);
            
        }
        
void curve(float d){
 stroke( t, 1, 0.75,0.6 );
           fill( 0, 0.016 );
            strokeWeight(random(0,1.4));
            beginShape();
            curveVertex( -100, 0 );
            for( int i=0; i<=n; i++ ) {
                float xx = i * height / n;
                noiseSeed(0);
                float yy = noise( i * 0.4, t*d ) * 400 ;
                curveVertex(xx, yy );
            }
            curveVertex( height+voice*100, 0 );
            endShape();           
            t=t>vr?0:t+0.005; 
}
void mousePressed() {
  if (music.isPlaying()) {
    music.pause();
  } else {
    music.play();
  }
}
void keyPressed() {
  if (music.isPlaying()) {
    music.pause();
  } else {
    music.play();
  }
}
