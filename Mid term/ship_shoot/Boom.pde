class Boom{
  private PVector position;
  private PVector velocity;
  private PVector acceleration;
  private float size = random(5,200);
  private float lifespan;
  
  Boom(PVector l)
 {
    acceleration = new PVector(random(-0.1,0.1), random(-0.1,0.1));
    velocity = new PVector(random(-4,4), random(-4,4));
    position = l.copy();
    lifespan = 100.0;
  }

  void run()
 {
    update();
    display();
  }

  // Method to update position
  void update()
 {
    
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 1.5;
    size-=2 ;
  }
  
  // Method to display
  void display()
 {

    
    fill(255,lifespan);
    ellipse(position.x, position.y, size, size);
  }

  // Is the particle still useful?
  boolean isDead() 
  {
    if ( lifespan < 0.0&&size<=0) 
    {
      return true;
    } 
    else {
      return false;
    }
  }
}
