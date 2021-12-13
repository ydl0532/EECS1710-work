
Cell[][] _cellArray;
int _cellSize = 10;
int _numX, _numY;

void setup() {
  frameRate(6);
  size(800, 500);
  _numX = floor(width/_cellSize);
  _numY = floor(height/_cellSize);
  restart();
}

void restart() {
  _cellArray = new Cell[_numX][_numY];
  for (int x=0; x<_numX; x++) {
    for (int y=0; y<_numY; y++) {
      Cell newCell = new Cell(x, y);
      _cellArray[x][y] = newCell;
    }
  }
  for (int x=0; x<_numX; x++) {
    for (int y=0; y<_numY; y++) {
      int above = y-1;
      int below = y+1;
      int left = x-1;
      int right = x+1;
      if (above < 0) { 
        above = _numY-1;
      }
      if (below == _numY) { 
        below = 0;
      }
      if (left < 0) { 
        left = _numX-1;
      }
      if (right == _numX) { 
        right = 0;
      }
      _cellArray[x][y].addNeighbor(_cellArray[left][above]);
      _cellArray[x][y].addNeighbor(_cellArray[left][y]);
      _cellArray[x][y].addNeighbor(_cellArray[left][below]);
      _cellArray[x][y].addNeighbor(_cellArray[x][below]);
      _cellArray[x][y].addNeighbor(_cellArray[right][below]);
      _cellArray[x][y].addNeighbor(_cellArray[right][y]);
      _cellArray[x][y].addNeighbor(_cellArray[right][above]);
      _cellArray[x][y].addNeighbor(_cellArray[x][above]);
    }
  }
}

void draw() {
  background(200);
  // calculate next state
  for (int x=0; x<_numX; x++) {
    for (int y=0; y<_numY; y++) {
      _cellArray[x][y].calcNextState();
    }
  }
  translate(_cellSize/2, _cellSize/2);
  for (int x=0; x<_numX; x++) {
    for (int y=0; y<_numY; y++) {
      _cellArray[x][y].drawMe();
    }
  }
}

void mousePressed() {
  restart();
}


// =================== object =================
class Cell {
  float x, y;
  boolean state, nextState;
  color fillcol;
  float alph;
  Cell[] neighbors;

  // constructor
  Cell(float ex, float why) {
    fillcol = color(random(255), random(150), random(100));
    alph = random(150);
    x = ex * _cellSize;
    y = why * _cellSize;
    if (random(2)>1) {
      nextState = true;
    } 
    else {
      nextState = false;
    }
    state = nextState;
    neighbors = new Cell[0];   // creating an empty array
  }

  void addNeighbor(Cell cell) {
    neighbors = (Cell[])append(neighbors, cell);
  }

  void calcNextState() {
    int liveCount = 0;
    if (state) { liveCount++; }
    for (int i=0; i<neighbors.length; i++) {
      if (neighbors[i].state == true) {
        liveCount++;
      }
    }
    
    if (liveCount <= 4) {
      nextState = false;
    } else if (liveCount > 4) {
      nextState = true;
    }
    if ((liveCount == 4) || (liveCount == 5)) {
      nextState = !nextState;
    }
  }

  void drawMe() {
    state = nextState;
    if (state == true) {
      fill(fillcol, alph);
      noStroke();
    } 
    else {
      fill(50,40);
      stroke(1);
    }
    ellipse(x, y, _cellSize*2, _cellSize*2);
  }
}
