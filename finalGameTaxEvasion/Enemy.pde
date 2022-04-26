class Enemy {
  //fields
  int enemyX;
  int enemyY;
  int enemyW;

  int eTop;
  int eBottom;
  int eLeft;
  int eRight;

  boolean playHey;
  //constructor
  Enemy(int startingX, int startingY) {
    enemyX = startingX;
    enemyY = startingY;
    enemyW = 60;
    eTop = enemyY;
    eBottom = enemyY + enemyW;
    eLeft = enemyX;
    eRight = enemyX + enemyW;
    playHey = false;
  }
  //render function
  void render() {
  }
  //reset enemy boundaries
  void resetBoundaries() {
    eTop = enemyY;
    eBottom = enemyY + enemyW;
    eRight = enemyX + enemyW;
    eLeft = enemyX;
  }
  //check if player touches enemy
  void hitbox() {
    if (player.pRight >= eLeft && player.pLeft <= eRight) {
      if (player.pTop <= eBottom && player.pBottom >= eTop) {
      //  println("ENEMY HIT");
        player.dead = true;
      }
    }
  }
  
    void move() {
    if (hasMoved == true) {
      enemyY += 1;
    }
  }

  //check if player is near enemy, trigger 'HEY'
  void hey(Player player) {
    if (player.pRight >= eLeft-50 && player.pLeft <= eRight+50) {
      if (player.pTop <= eBottom+50 && player.pBottom >= eTop-50) { 
        playHey = true;
      }
    }
      
      else {
        playHey = false;
      }
  }
  
  
  void end(){
    enemyW = 60;
    eTop = enemyY;
    eBottom = enemyY + enemyW;
    eLeft = enemyX;
    eRight = enemyX + enemyW;
    playHey = false;
  }
}
