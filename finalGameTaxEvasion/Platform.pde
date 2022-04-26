class Platform {

  //fields
  int platformX;
  int platformY;
  int platformW;
  int platformH;

  color platformC;

  int platTop;
  int platBottom;
  int platLeft;
  int platRight;



  float platformYSpeed;




  //constructor
  Platform(int startingX, int startingY) {
    platformX = startingX;
    platformY = startingY;
    platformW = 140;
    platformH = 20;
    platformC = color(0, 0, 255);
    platformYSpeed = 1.;
    platTop = platformY;
    platBottom = platformY + platformH;
    platLeft = platformX;
    platRight = platformX + platformW;
    finished = false;
  }



  //render platform
  void render() {
    fill(0, 0, 255);
    rect(platformX, platformY, platformW, platformH);
  }

  //reset platform boundaries
  void resetBoundaries() {
    platTop = platformY;
    platBottom = platformY + platformH;
    platLeft = platformX;
    platRight = platformX + platformW;
  }

  //check if player lands ons
  void landedOn(Player player) {
    if (player.falling == true && player.pBottom >= platTop  && player.pTop <= platBottom) {
      if (player.pRight >= platLeft && player.pLeft <= platRight) {
        player.falling = false;
        player.playerY = platTop - player.playerW;
        if (plus == true) {
          player.playerY += 50;
          plus = false;
        }
      } else {
        player.falling = true;
      }
    }
  }

  void end() {
    //for (Platform eachPlatform : platforms) {
    //  platforms.remove(eachPlatform);
    //}
    //platforms.add(new Platform(130, height-100));
    //platforms.add(new Platform(400, 430));
    //platforms.add(new Platform(30, 300));
    //platforms.add(new Platform(80, 200));
    //platforms.add(new Platform(600, 200));
    //platforms.add(new Platform(250, 100));
    //platforms.add(new Platform(500, 530));
    //platforms.add(new Platform(0, 20));
    //platforms.add(new Platform(470, 0));
    //platforms.add(new Platform(width/2, height/2));
    platformW = 140;
    platformH = 20;
    platformC = color(0, 0, 255);
    platTop = platformY;
    platBottom = platformY + platformH;
    platLeft = platformX;
    platRight = platformX + platformW;
  }


  void move() {
    if (hasMoved == true) {
      platformY += platformYSpeed;
    }
  }
  
  boolean finished(){
    if (platBottom > height){
      return true;
  }
  else{
    return false;
  }
}
}
