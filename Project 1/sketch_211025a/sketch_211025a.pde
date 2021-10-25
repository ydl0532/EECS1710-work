int canDle = 150;
Ball [] candles = new Ball[canDle];
Attractor attractor;
int bgHue, bgSatur, bgBright;
PImage img1;

void setup () {
  size(800, 600);
  colorMode(HSB, 360, 100, 100, 100);
  background(0);
  
  bgHue = 210;
  bgSatur = 50;
  bgBright = 0;

  for (int i = 0; i < canDle; i++) {
    candles [i] = new Ball(random(5, 10), i, candles);
  }
  attractor = new Attractor(30);
}

void draw () {
  //background
  noStroke();
  fill(bgHue, bgSatur, bgBright, 35);
  rect(0, 0, width, height);
  
  attractor.display();

  for (int i = 0; i < candles.length; i++) {

    PVector force = attractor.attract(candles[i]);
    
    candles[i].ballCollision();

    float dist = PVector.dist(candles[i].location, attractor.location);
    if (dist < attractor.radius*5) {
      force.mult(-4);
      candles[i].applyForce(force);
    } else if (dist > attractor.radius*5) {
      candles[i].applyForce(force);
    }
    
    candles[i].movement();
    candles[i].boundaryCollision();
    candles[i].display();
  }
}
class Attractor {
  float radius; 
  float G;  
  PVector location;

  PImage glow;

  Attractor (float _radius) {
    location = new PVector(0, 0);
    radius = _radius;
    G = 1;

    glow = loadImage("lighter.jpg");
  }

  PVector attract (Ball b) {
    PVector force = PVector.sub(location, b.location);
    float d = force.mag(); 
    d = constrain(d, 5.0, 25.0);  
    force.normalize();  
    float strength = (G * radius * b.radius) / (d * d); 
    force.mult(strength);      
    return force;
  }

  void display () {
    location = new PVector(mouseX, mouseY);

    pushMatrix();
    translate(location.x, location.y);
    scale(radius*0.02, radius*0.02);
    tint(60,80,80);
    image(glow, -glow.width/2, -glow.height/2);
    popMatrix();

    fill(60, 60, 80);
  }
}

class Ball {
  float radius; //mass
  PVector location, velocity, acceleration;

  int trailNum = 50;
  int[] xTrail = new int[trailNum];
  int[] yTrail = new int[trailNum];
  int indexPosition = 0;

  float maxSpeed, maxForce; 

  int i_; 
  Ball [] othercandles;

  PImage glow;

  Ball (float _radius, int _i_, Ball [] _othercandles) {
    location = new PVector(random(width), random(height));
    velocity = new PVector(1, 1);
    acceleration = new PVector(0, 0);
    radius = _radius;
    maxSpeed = 5;
    maxForce = 0.05;

    i_ = _i_;
    othercandles = _othercandles;

    glow = loadImage("lighter.jpg");

  }

  void ballCollision () {
    for (int j = i_ + 1; j < canDle; j++) {
      PVector delta = PVector.sub(othercandles[j].location, location);
      float dist = sqrt(sq(delta.x) + sq(delta.y));
      if (dist < (radius + othercandles[j].radius)) {
        PVector normalPlane = PVector.div(delta, dist);
        PVector midpoint = PVector.add(location, othercandles[j].location);
        midpoint.div(2);

        location.x = midpoint.x - radius * normalPlane.x;
        location.y = midpoint.y - radius * normalPlane.y;
        othercandles[j].location.x = midpoint.x + othercandles[j].radius * normalPlane.x;
        othercandles[j].location.y = midpoint.y + othercandles[j].radius * normalPlane.y;

        float dVector = (velocity.x - othercandles[j].velocity.x) * normalPlane.x + (velocity.y - othercandles[j].velocity.y) * normalPlane.y;

        PVector dVelocity = normalPlane;
        dVelocity.mult(dVector);
        velocity.sub(dVelocity);
        othercandles[j].velocity.add(dVelocity);
      }
    }
  }

  void applyForce (PVector force) {
    PVector friction = new PVector(velocity.x, velocity.y);
     friction.normalize(); 
     float c = -0.2; 
     friction.mult(c); 
     force.add(friction);

    PVector f = PVector.div(force, radius);
    acceleration.add(f);
  }

  void movement () {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  void boundaryCollision () {
    if (location.x < radius) {
      location.x = radius;
      velocity.x *= -1;
    }
    if (location.x > width-radius) {
      location.x = width-radius;
      velocity.x *= -1;
    }
    if (location.y < radius) {
      location.y = radius;
      velocity.y *= -1;
    }
    if (location.y > height-radius) {
      location.y = height-radius;
      velocity.y *= -1;
    }
  }

  void display () {
    noStroke();
    fill(260, bgSatur, 75, 70);
     img1= loadImage("candle.png");
    image(img1,location.x, location.y, 40, 40);
  }
}
