class Enemy
{
  private PVector p;
  private float s, sp;
  private int hp;
  
  public Enemy(PVector pos, float sz, float spd, int h)
  {
    p = pos;
    s = sz;
    sp = spd;
    hp = h;
  }
  
  public void update()
  {
    p.y += sp;
  }
  
  public void draw()
  {
    fill(255);
    ellipse(p.x, p.y, s, s);
    fill(0);
    textSize(s / 2);
    textAlign(CENTER, CENTER);
    text(hp, p.x, p.y);
  }
}
