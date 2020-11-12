//*
// ***** SEGMENT CLASS *****
// This class will be used to represent each part of the moving snake.
//*

class Segment {

  //Add x and y member variables. They will hold the corner location of each segment of the snake.
  int x;
  int y;

  // Add a constructor with parameters to initialize each variable.
  Segment(int x, int y) {
    this.x=x;
    this.y=y;
  }
}


//*
// ***** GAME VARIABLES *****
// All the game variables that will be shared by the game methods are here
//*
Segment sHead;
int foodX;
int foodY;
int sDirection=UP;
int foodEaten=0;
ArrayList<Segment>sTail=new ArrayList<Segment>();

//*
// ***** SETUP METHODS *****
// These methods are called at the start of the game.
//*

void setup() {
  size(500, 500);
  sHead = new Segment(100, 100);
  frameRate(20);
  dropFood();
  frameRate(20);
}

void dropFood() {
  //Set the food in a new random location
  foodX = ((int)random(50)*10);
  foodY = ((int)random(50)*10);
}



//*
// ***** DRAW METHODS *****
// These methods are used to draw the snake and its food 
//*

void draw() {
  background(#080808);
  move();
  drawFood();
  drawSnake();
  eat();
}

void drawFood() {
  //Draw the food
  fill(#FF0505);
  rect(foodX, foodY, 10, 10);
}

void drawSnake() {
  //Draw the head of the snake followed by its tail
  fill(#1FFF03);
  rect(sHead.x, sHead.y, 10, 10);
  manageTail();
}


//*
// ***** TAIL MANAGEMENT METHODS *****
// These methods make sure the tail is the correct length.
//*

void drawTail() {
  //Draw each segment of the tail 
  for (Segment s : sTail) {
    rect(s.x, s.y, 10, 10);
  }
}

void manageTail() {
  //After drawing the tail, add a new segment at the "start" of the tail and remove the one at the "end" 
  //This produces the illusion of the snake tail moving.
  checkTailCollision();
  drawTail();
  sTail.add(new Segment(sHead.x, sHead.y));
  sTail.remove(0);
}

void checkTailCollision() {
  //If the snake crosses its own tail, shrink the tail back to one segment
  for (Segment s : sTail) {
    if (sHead.x==s.x && sHead.y==s.y) {
      foodEaten=0;
      sTail=new ArrayList<Segment>();
      sTail.add(new Segment(sHead.x, sHead.y));
      return;
    }
  }
}



//*
// ***** CONTROL METHODS *****
// These methods are used to change what is happening to the snake
//*

void keyPressed() {
  //Set the direction of the snake according to the arrow keys pressed
  if (keyCode==UP) {
    sDirection=UP;
  } else if (keyCode==DOWN) {
    sDirection=DOWN;
  } else if (keyCode==RIGHT) {
    sDirection=RIGHT;
  } else if (keyCode==LEFT) {
    sDirection=LEFT;
  }
}

void move() {
  //Change the location of the Snake head based on the direction it is moving.


  switch(sDirection) {
  case UP:
    sHead.y=sHead.y-10;// move head up here 
    break;
  case DOWN:
    sHead.y=sHead.y+10;// move head down here 
    break;
  case LEFT:
    sHead.x=sHead.x-10;// figure it out 
    break;
  case RIGHT:
    sHead.x=sHead.x+10;// mystery code goes here 
    break;
  }
  checkBoundaries();
}

void checkBoundaries() {
  //If the snake leaves the frame, make it reappear on the other side
  if (sHead.x>width) {
    sHead.x = width-width;
  }
  if (sHead.x<width-width) {
    sHead.x = width;
  }
  if (sHead.y>height) {
    sHead.y=height-height;
  }
  if (sHead.y<height-height) {
    sHead.y=height;
  }
}



void eat() {
  //When the snake eats the food, its tail should grow and more food appear
  if (sHead.x==foodX && sHead.y==foodY) {
    foodEaten+=1;
    foodX = ((int)random(50)*10);
    foodY = ((int)random(50)*10);
    sTail.add(new Segment(sHead.x, sHead.y));
  }
}
