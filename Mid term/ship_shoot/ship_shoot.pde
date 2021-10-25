public ArrayList<Bullet> bullets = new ArrayList<Bullet>();
public ArrayList<Enemy>  enemies = new ArrayList<Enemy>();
public ArrayList<Boom> booms = new ArrayList<Boom>();
public ArrayList<Background> particles = new ArrayList<Background>();
public ArrayList<Manustar> manustar = new ArrayList<Manustar>();
public int lvl = 1, kills = 0, lives = 3;
//public boolean allowCheats = true;
public int [] gameKeys = { 32 , 37 , 39 };
public boolean [] keyStates = { false , false , false };
public Ship ship;
public boolean start = false;

void setup()
{
  size(800, 1000);
  frameRate(60);
  noStroke();
  
  ship = new Ship(20); 
}

void keyPressed()
{
  
  manageKeys(keyCode, true); 
}

void keyReleased()
{
  manageKeys(keyCode, false);
}

void draw()
{
  
  if (ship.isAlive)
  {
    if(frameCount%10==0){
    particles.add(new Background(new PVector(random(0,width), 0)));
    }
    
     for (int i = particles.size()-1; i >= 0; i--)
      {
        Background p = particles.get(i);
        p.run();
        if (p.isDead())
        {
          particles.remove(i);
        }
      }
    
    fill(random(0,lvl),random(0,lvl*1.5),random(0,lvl*2),14);
    rect(0,0,width,height);
    //background(0);
    if(!start)
    {
      GameStart();
    }
    if(start)
    {
     //Text
    textSize(100);
    fill(100);
    textAlign(CENTER, CENTER);
    text( "\nLevel " + lvl + "\nKills " + kills + "\nLives " + lives + "\n", width /2, height /2);
    
    //Move ship
    if (keyStates[1]  && ship.x - ship.w > 0)      ship.x -= 5;
    if (keyStates[2]  && ship.x + ship.w < width)  ship.x += 5;
    
    //Fire bullet

    if (keyStates[0])
    {
      if(frameCount%10 == 0){
      if(lvl < 5){
      bullets.add(new Bullet(new PVector(ship.x, height - ship.h), 10,0));
    }
      
      else if(lvl >= 5 && lvl < 10){
      bullets.add(new Bullet(new PVector(ship.x-20, height - ship.h), 10,0));
      bullets.add(new Bullet(new PVector(ship.x+20, height - ship.h), 10,0));
    }
    else if(lvl >= 10 && lvl < 20){
      bullets.add(new Bullet(new PVector(ship.x-25, height - ship.h), 10,0));
      bullets.add(new Bullet(new PVector(ship.x, height - ship.h), 10,0));
      bullets.add(new Bullet(new PVector(ship.x+25, height - ship.h), 10,0));
    }
    else if(lvl >= 20 && lvl < 25){
      bullets.add(new Bullet(new PVector(ship.x-50, height - ship.h), 10,1));
      bullets.add(new Bullet(new PVector(ship.x-25, height - ship.h), 10,0));
      bullets.add(new Bullet(new PVector(ship.x, height - ship.h), 10,0));
      bullets.add(new Bullet(new PVector(ship.x+25, height - ship.h), 10,0));
      bullets.add(new Bullet(new PVector(ship.x+50, height - ship.h), 10,2));
    }
    else if(lvl >= 25&& lvl < 30){
      bullets.add(new Bullet(new PVector(ship.x-50, height - ship.h), 10,1));
      bullets.add(new Bullet(new PVector(ship.x-25, height - ship.h), 10,1));
      bullets.add(new Bullet(new PVector(ship.x-50, height - ship.h), 10,0));
      bullets.add(new Bullet(new PVector(ship.x-20, height - ship.h), 10,0));
      bullets.add(new Bullet(new PVector(ship.x+20, height - ship.h), 10,0));
      bullets.add(new Bullet(new PVector(ship.x+50, height - ship.h), 10,0));
      bullets.add(new Bullet(new PVector(ship.x+25, height - ship.h), 10,2));
      bullets.add(new Bullet(new PVector(ship.x+50, height - ship.h), 10,2));
    }
    
    
    else if(lvl >= 30 && lvl < 40){
      
      bullets.add(new Bullet(new PVector(ship.x-50, height - ship.h), 10,1));
      bullets.add(new Bullet(new PVector(ship.x-25, height - ship.h), 10,1));
      bullets.add(new Bullet(new PVector(ship.x-25, height - ship.h), 10,0));
      bullets.add(new Bullet(new PVector(ship.x-50, height - ship.h), 10,0));
      bullets.add(new Bullet(new PVector(ship.x, height - ship.h), 10,0));
      bullets.add(new Bullet(new PVector(ship.x+50, height - ship.h), 10,0));
      bullets.add(new Bullet(new PVector(ship.x+25, height - ship.h), 10,0));
      bullets.add(new Bullet(new PVector(ship.x+25, height - ship.h), 10,2));
      bullets.add(new Bullet(new PVector(ship.x+50, height - ship.h), 10,2));
    }
      }
  }
    //Spawn enemies
    if (frameCount % 50 == 0)
    {
      float s = random(20, 270);
      float x = random(s, width - s);
      float sp = random(0.5, 4);
      int hp = int(random(1, lvl));
      enemies.add(new Enemy(new PVector(x, -10), s, sp, hp));
      //if(lvl == 9){
      //enemies.add(new Enemy(new PVector(width / 2, -10), 500, 0.5, 500));
      //}
    } 
    
    //Update
    for (Enemy e : enemies) e.update();
    for (Bullet b: bullets) b.update();
    
    
    //Draw
    for (Enemy e : enemies) e.draw();
    for (Bullet b: bullets) b.draw();
    
    ship.draw();
    
    //Loop through each enemy
    for (int e = enemies.size() - 1; e >= 0; e--)
    {
      Enemy en = enemies.get(e); 
      //Enemy makes it all the way to the bottom, if it does, dont check hit() since enemy is gone off screen
      if (en.p.y - en.s / 2 > height)
      {
        background(255);
        if (--lives == 0)
        {
          fill(0);
          rect(0,0,width,height);
          textSize(200);
          fill(255,0,0);
          textAlign(CENTER, CENTER);
          text("Game \n Over", width /2, height /2);
          textSize(30);
          fill(255);
          text("Your score:"+kills, width /2, height -170);
          ship.isAlive = false;
        }
        
        enemies.remove(e);
      }
      else
      {
        //Loop through each bullet
        for (int b = bullets.size() - 1; b >= 0; b--)
        {
          //If bullet leaves screen, remove it and dont loop through all enemies since bullet is gone
          if (bullets.get(b).p.y < 0) 
          {
            bullets.remove(b);
          }
          else if (hit(enemies.get(e), bullets.get(b)))
          {
            bullets.remove(b);
            
            if (--en.hp == 0)  
            {
              if (++kills % 5 == 0)
              {
                if (++lvl == 40) 
                {
                  fill(255,50);
                  rect(0,0,width,height);
                  textSize(200);
                  fill(0,255,0);
                  textAlign(CENTER, CENTER);
                  text("YOU \n WIN!", width /2, height /2);
                  ship.isAlive = false;
                }
                ++lives;
              }
              enemies.remove(e);
              //Enemy is gone, stop checking against next bullet
              for(int i = 0; i <= 20; i++) {
              booms.add(new Boom(new PVector(en.p.x,en.p.y)));  }  
              b = -1;
            }
          }
        }
      }
    } 
  }
}
for (int i = booms.size()-1; i >= 0; i--)
  {
    Boom o = booms.get(i);
    o.run();
    if (o.isDead())
    {
      booms.remove(i);
    }
  }
}

public boolean hit(Enemy e, Bullet b)
{
  return (dist(b.p.x, b.p.y, e.p.x, e.p.y) < e.s / 2);
}


public void manageKeys(int code, boolean state) 
{
  for (int i = 0; i < gameKeys.length; i++)
  {
    if (gameKeys[i] == code) keyStates[i] = state;
  }
}


int colors = 0;
int cc = 2;
void GameStart()
{
  textSize(100);
   colors= colors +cc;
   if(colors >=255){
   cc = cc*-1;
   }
    if(colors <=0)
    {
    cc = cc*-1;
    }
  if(frameCount%10==0){
  manustar.add(new Manustar(new PVector(0, random(410,430))));
  manustar.add(new Manustar(new PVector(0, random(650,670))));
    }
    
     for (int i = particles.size()-1; i >= 0; i--)
      {
        Manustar m = manustar.get(i);
        m.run();
        if (m.isDead())
        {
          particles.remove(i);
        }
      }
  
  
  fill(colors);
  textAlign(CENTER, CENTER);
  text("Welcome Space!",width/2,height/2-180);

  textSize(30);
  fill(255);
  text("\n Arrow keys to move \n Space key to shoot bullet \n If you let enemy go through bottom,you lose one lives \n Level 40 to win", width /2, height /2);
  fill(colors);
  text("Press 'space' to star!", width /2, height /2+200);
  if (keyStates[0])
    {
      start = true;
      background(255);
    }
  
}
