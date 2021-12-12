PImage img;
void preload() {
    img = loadImage("img.png"); 
}

void setup() {
    img = loadImage("img.png"); 
    size(696, 393);
    img.loadPixels();
    background(255);
    imageMode(CENTER);
    frameRate(400);
}

void draw() {

    var x = constrain(floor(random(width)), 0, width + 1);
    var y = constrain(floor(random(height)), 0, height + 1);
    var w = random(5, 30);
    var h = random(5, 30);

    noStroke();
    var picCol = img.get(x, y);
    fill(picCol);
    arc(x, y, w, h, HALF_PI, PI);
}
