class Player {
  //fields

  boolean movingRight;
  boolean movingLeft;
  boolean jumping;
  boolean falling;
  boolean dead;

  int playerX;
  int playerY;
  int playerW;
  int playerH;

  int playerXSpeed;
  int playerYSpeed;

  int jumpHeight;
  int peakY;

  int pTop;
  int pBottom;
  int pRight;
  int pLeft;
  
  int pLimit;



  //constructor
  Player(int startingX, int startingY, int startingW) {
    playerX = startingX;
    playerY = startingY;
    playerW = startingW;
    playerXSpeed = 7;
    playerYSpeed = 7;
    jumpHeight = 100;
    peakY = playerY - jumpHeight;
    pTop = playerY;
    pBottom = playerY + playerW;
    pRight = playerX + playerW;
    pLeft = playerX;
    movingRight = false;
    movingLeft = false;
    jumping = false;
    falling = false;
    dead = false;
    pLimit = height/2;
  }

  //show player
  void render() {
    fill(255);
    man.resize(60,60);
    image(man, playerX, playerY);
  }
  //move player
  void move() {
    if (movingRight == true) {
      playerX += playerXSpeed;
    }
    if (movingLeft == true) {
      playerX -= playerXSpeed;
    }
  }

  //player jump
  void jump() {
    if (jumping == true && falling != true) {
      playerY -= playerYSpeed;
    }
  }

  //check if jump has reached its peak
  void reachedTopOfJump() {
    if (playerY <= peakY && jumping == true) {
      jumping = false;
      falling = true;
    }
  }

  //player falling
  void falling() {
    if (falling == true && jumping != true) {
      playerY += playerYSpeed;
    }
  }

  //check if player has landed on bottom of screen
  void landed() {
    if (pBottom >= height) {
      falling = false;
      peakY = playerY - jumpHeight;
    }
  }

  //reset player's boundaries
  void resetBoundaries() {
    pTop = playerY;
    pBottom = playerY + playerW;
    pRight = playerX + playerW;
    pLeft = playerX;
  }

  //check if player is on platform to fall off
  void fallOffPlatform(ArrayList<Platform> somePlatforms) {
    if (player.jumping == false && pBottom <= height) {
      boolean onPlatform = false;


      for (Platform eachPlatform : somePlatforms) {
        
        //if (eachPlatform.finished()){
        //  somePlatforms.remove(eachPlatform);
        //}
        //if (somePlatforms.size()<12){
        //  somePlatforms.add(new Platform(int(random(0,width-eachPlatform.platformW)),0));
        //}
        if (falling == true && pBottom >= eachPlatform.platTop) {
          if (pRight <= eachPlatform.platRight && pLeft >= eachPlatform.platLeft) {
            onPlatform = true;
            eachPlatform.end();
          }
        }
      }

      if (onPlatform == false) {
        falling = true;
      }
    }
  }
    //check if player dies
    void playerDead(){
      if (playerY >= height-playerW){
        dead = true;
      }
      else{
        dead = false;
      }
    }
    
    void end(){
    
    playerX = width/2;
    playerY = height-100;
    playerW = 60;
    playerXSpeed = 7;
    playerYSpeed = 7;
    jumpHeight = 100;
    peakY = playerY - jumpHeight;
    pTop = playerY;
    pBottom = playerY + playerW;
    pRight = playerX + playerW;
    pLeft = playerX;
    movingRight = false;
    movingLeft = false;
    jumping = false;
    falling = false;
    dead = false;
    hasMoved = false;
    }
  
  
  

  ////player wall detection
  //void wallDetect(){
  //  // detects wall detection for the right wall
  //    if (x+w >= width) {
  //      movingRight = false;
  //    }
  //    // wall detection for left wall
  //    if (x <= 0) {
  //      movingLeft = false;
  //    }

  //    // wall detection for the bottom wall
  //    if (y+w >= height) {
  //      death = true;
  //      println("died");
  //    }

  //}
}
