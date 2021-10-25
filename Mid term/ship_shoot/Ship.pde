class Ship
{
  private float x, w, h;
  private boolean isAlive;
  
  public Ship(float wd)
  {
    x = width / 2;
    w = wd;
    h = wd + wd / 5;
    isAlive = true;
  }
  
  public void draw()
  {
    
    
    
    fill(255);
    rect(x - w / 2, height - h - 5, w, h);
    fill(255);
    rect(x - w, height - h, w / 2, h - 5);
    rect(x + w / 2, height - h, w / 2, h - 5);
  }
}
