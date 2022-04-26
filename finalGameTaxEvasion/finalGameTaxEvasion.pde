import processing.sound.*;
//delcare image vars
PImage backgroundImage;
PImage sadestSun;
PImage taxCollector;
PImage man;

PImage[] llamaImages = new PImage [6];

//declare soundfiels
SoundFile backgroundMusic;
SoundFile jump;
SoundFile hey;
SoundFile sadSong;

//declaring players and flatforms
Player player;
Platform platform1;
Enemy enemy;

//declaring array list of platforms
ArrayList<Platform> platforms;
ArrayList<Enemy> enemies;

//state var
int state = 0;

//millis timer
int startTime = millis();
int endTime;
int interval1 = 1000;
int interval2 = 2000;

boolean hasMoved = false;
boolean plus = false;

//score vars
int score;

void setup() {
  //settings
  size(600, 800);
  background(90);
  score = 0;
  //make a new player, platforms, enemy
  player = new Player(width/2, height-100, 60);
  enemy = new Enemy(300, 300);
  platforms = new ArrayList<Platform>();
  enemies = new ArrayList<Enemy>();
  //initilize image var
  backgroundImage = loadImage("backgroundImage.jpeg");
  sadestSun = loadImage("sadestSun.jpeg");
  taxCollector = loadImage("taxCollector.png");
  man = loadImage("man.png");
  //add platforms to array list
  platforms.add(new Platform(130, height-100));
  platforms.add(new Platform(300, 670));
  platforms.add(new Platform(100, 590));
  platforms.add(new Platform(200, 460));
  platforms.add(new Platform(500, 320));
  platforms.add(new Platform(350, 280));
  platforms.add(new Platform(100, 390));
  platforms.add(new Platform(500, 200));
  platforms.add(new Platform(170, 160));
  platforms.add(new Platform(width/2, height/2));
  platforms.add(new Platform(210, 40));
  platforms.add(new Platform(60, 260));











  //initialzing sounds
  backgroundMusic = new SoundFile(this, "mixkit-dance-with-me-3.mp3");
  jump = new SoundFile(this, "jump.wav");
  hey = new SoundFile(this, "lego-city-hey-3.mp3");
  sadSong = new SoundFile(this, "sadSong.mp3");
}



void draw() {
  println(score);
  switch(state) {
  case 0:
    sadSong.stop();
    backgroundImage.resize(600, 800);
    background(backgroundImage);
    fill(255,0,0);
    textSize(20);
    text("This game does not condone law breaking of any kind", width/2-215, height-20);
    fill(180, 180, 180);
    textSize(40);
    //make words flash and appear
    endTime = millis();
    if (endTime - startTime >= interval1) {
      text("Press 's' to start evading your taxes!", width/2-300, height/2-300);
      text("C'mon! It'll be fun!", width/2-140, height/2-200);
      text("Or, press 'h' for help!", width/2-165, height/2-100);
      
    }
    if (endTime - startTime >= interval2) {
      background(backgroundImage);
      startTime = millis();
    }
    //check if background music is already playing
    if (!backgroundMusic.isPlaying()) {
      backgroundMusic.amp(.2);
      backgroundMusic.play();
    }
    break;
  case 1:
    sadSong.stop();
    background(backgroundImage);
    textSize(20);
    fill(255,255,0);
    text("Your score: "+score, 445, 25);


    //call funtions
    player.render();
    player.move();
    player.jump();
    player.falling();
    player.reachedTopOfJump();
    player.resetBoundaries();
    player.landed();
    player.fallOffPlatform(platforms);
    player.playerDead();
    //enemy.render();
    //enemy.resetBoundaries();
    //enemy.hitbox();
    //enemy.hey();

    for (Platform eachPlatform : platforms) {
      eachPlatform.render();
      eachPlatform.resetBoundaries();
      eachPlatform.landedOn(player);
      eachPlatform.move();
    }

    for (Enemy eachEnemy : enemies) {
      eachEnemy.render();
      taxCollector.resize(eachEnemy.enemyW, eachEnemy.enemyW);
      image(taxCollector, eachEnemy.enemyX, eachEnemy.enemyY);
      eachEnemy.resetBoundaries();
      eachEnemy.hitbox();
      eachEnemy.hey(player);
      eachEnemy.move();
      //check if HEY is playing
      if (eachEnemy.playHey == true && !hey.isPlaying()) {
        hey.amp(.5);
        hey.play();
    }
    
    }
    for (int i = platforms.size()-1; i >= 0; i--) {
      Platform plat = platforms.get(i);
      if (plat.finished()) {
        platforms.remove(i);
      }
      if (platforms.size()<12) {
        platforms.add(new Platform(int(random(0, width-plat.platformW)), 0));
        // add an enemy if there are not enough on the screen
        if (enemies.size() < 6 && random(0,10)<=1) {
          Platform newPlat = platforms.get(platforms.size()-1);
          enemies.add(new Enemy(int(random(newPlat.platLeft, newPlat.platRight)),
            newPlat.platTop-60));
        }
      }
    }
    
    for (int i = enemies.size()-1; i >= 0; i--) {
      Enemy en = enemies.get(i);
      if (en.eTop>height) {
        enemies.remove(i);
      }
    }


    //check if player dies
    if (player.dead == true && hasMoved == true) {
      state = 2;
    }
    
    //add to score
    if (player.dead != true && hasMoved == true) {
      score += 1;
    }
    
    


    break;
  case 2:
    hey.stop();
    //check if sad music is already playing
    if (!sadSong.isPlaying()) {
      sadSong.amp(.2);
      sadSong.play();
    }
    sadestSun.resize(600,600);
    background(255);
    image(sadestSun, 0, 200);
    fill(0);
    textSize(30);
    text("Your score: "+score, width/2-100, height/2-250);
    text("Oh no! You've stopped evading your taxes! :(", width/2-275, height/2-300);
    text("Press 'r' to restart and do it again!", width/2-215, height/2-200);
    enemy.end();
    player.end();
    backgroundMusic.stop();
    break;
    
  case 3:
    sadSong.stop();
    background(backgroundImage);
    //check if background music is already playing
    if (!backgroundMusic.isPlaying()) {
      backgroundMusic.amp(.2);
      backgroundMusic.play();
    }
    text("Press 'w' to jump", width/2-135, 200);
    text("Press 'a' to move left", width/2-190, 300);
    text("Press 'd' to move right", width/2-200, 400);
    text("Press 'b' to go back to home page", 30, 500);
    break;
    
    
    
  }
}

void keyPressed() {
  //check if player is jumping
  if (key == 'w' && player.falling != true && player.jumping != true && state == 1) {
    player.jumping = true;
    player.peakY = player.playerY - player.jumpHeight;
    if (!jump.isPlaying()) {
      jump.amp(.4);
      jump.play();
    }
  }
  //check if player is moving right
  if (key == 'd') {
    player.movingRight = true;
  }
  //check if player is moving left
  if (key == 'a') {
    player.movingLeft = true;
  }
  //check if player starts the game
  if (key == 's' && state == 0) {
    state = 1;
  }
  //check if player wants to restart
  if (key == 'r' && state == 2) {
    sadSong.stop();
    setup();
    state = 0;
    sadSong.pause();

  }
  //check if player needs help
  if (key == 'h' && state == 0){
    state = 3;
  }
  //check if player wants to go back to home page
  if (key == 'b' && state == 3){
    state = 0;
  }
}

void keyReleased() {
  //check if jumping key is released
  if (key == 'w' && state == 1) {
    player.jumping = false;
    player.falling = true;
    hasMoved = true;
  }
  //check if moving right key is released
  if (key == 'd') {
    player.movingRight = false;
  }
  //check if moving left key is released
  if (key == 'a') {
    player.movingLeft = false;
  }
}
