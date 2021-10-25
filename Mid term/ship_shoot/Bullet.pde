class Bullet
{
  private PVector p;
  private float s;
  private int w;

  
  public Bullet(PVector pos, float sz,int wh)
  {
    p = pos;
    s = sz;
    w = wh;
  }
  
  public void update()
  {
    p.y -= s;
    
    if(w == 1){
    p.x -=1;
    }else if(w ==2){
       p.x +=1;
    }
  }
  
  public void draw()
  {
    fill(255);
   
    rect(p.x-10, p.y-10, 20, 20);
  }
}
