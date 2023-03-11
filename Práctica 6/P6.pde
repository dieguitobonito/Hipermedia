// Variables para cargar imágenes
PImage wallpaper;
PImage rock;
PImage target;
PImage flippedTarget;
// Librería de sonido
import processing.sound.*;
SoundFile song;
SoundFile bow;
SoundFile hit1;
SoundFile hit2;
SoundFile hit3;

// Utilizadas para la intensidad del tiro
float distance; 
float power;

// Los pasos que habrá para que sea acorde a level
float intensities;

// Lo que hará que el tiro inicial sea al centro
int level = 5;

// Utilizadas para hacer el trazo
float x = 0;
float y = 0;
// Dos incrementos para los casos de level > 1 (2-10) y level < 1 (0-1)
float incX;
float incY = 100;

// Utilizadas por el endermite
float targetX = width/2;
float targetSpeed = 10;
float targetDirection = 1;
float targetY = 350;


// Timer
int seconds = 59;

// Score
int score = 0;

// Hace que la colisión aumente de 1 en 1 el puntaje,
// hay posibilidad que la colisión dure más de lo esperado
// agregando demasiados puntos
boolean scored = false;

// Hitbox de la bola de nieve
float snowWidth = 40;
float snowHeight = 40;

// Hitbox del endermite
float enderWidth = 50;
float enderHeight = 50;

void setup(){
  size(600, 400);
  // El archivo necesita dirección relativa
  wallpaper = loadImage("endCity.png");
  // Proyectil y su hitbox
  rock = loadImage("snowball.png");

  
  // Enemigo y su hitbox
  target = loadImage("endermite.png");

  

  frameRate(30);
  
  bow = new SoundFile(this, "bow.mp3");
  
  hit1 = new SoundFile(this, "hit1.mp3");
  hit2 = new SoundFile(this, "hit2.mp3");
  hit3 = new SoundFile(this, "hit3.mp3");
  
  song = new SoundFile(this, "calm1.mp3");
  song.loop();
    
  // La relación
  intensities = ((width*2)/10);
}

boolean update;

void mousePressed(){
  // Pausar
  update = false;
  
  if(mouseX > 500 && mouseX < 560 && mouseY > 10 && mouseY < 30)
    noLoop();
  // Aumentar tiro
  if(mouseX > 535 && mouseX < 560 && mouseY > 40 && mouseY < 60)
    if(level < 10 && level >= 0)
      level++;
  // Decrementar tiro
  if(mouseX > 500 && mouseX < 525 && mouseY > 40 && mouseY < 60)
    if(level >= 1)
      level--;
}

void mouseReleased(){
  loop();
}

float getY(){
  // Evitar que vaya al revés
  if(power > 0)
    y = sin(x/(power/PI)-PI/2) * height + height;
  // Reiniciar el tiro
  if(y > height)
    restartLaunch();
  return y;
}

void drawUI(){
  // Botón pausa
  fill(#FF0080);
  rect(500, 10, 60, 20, 3);
  fill(#FFFF00);
  triangle(515, 12, 515, 28, 525, 20);
  
  // Botón menos
  fill(#FF0080);
  rect(500, 40, 25, 20, 3);
  fill(#FFFF00);
  rect(505, 47, 15, 5, 1);
  
  // Botón más
  fill(#FF0080);
  rect(535, 40, 25, 20, 3);
  // - del +
  fill(#FFFF00);
  rect(540, 47, 15, 5, 1);
  // | del +
  fill(#FFFF00);
  rect(545, 42, 5, 15, 1);
  
  // Botón intensidad
  fill(#FFB8DB);
  rect(500, 70, 60, 30, 3);
  fill(#000000);
  text(level, 525, 90);
  
  // Botón timer
  fill(#FFB8DB);
  rect(500, 140, 60, 30, 3);
  fill(#000000);
  text(seconds, 525, 160);
  
  // Botón aciertos
  fill(#F03A95);
  rect(500, 180, 60, 30, 3);
  fill(#FFFFFF);
  text("Puntos", 510, 195);  
  text(score, 525, 205);

}

void nextPosition(){
  if(power > 0)
    x += incX;
  if(power == 0)
    y += incY;
}

boolean played = false;

void drawSnowball(){
  if(update == true)
     power = intensities * level;
    
  distance = sqrt(height * height + (power/2) * (power/2));
  incX = distance * 0.015;

  if(played == false){
      bow.play();
      played = true;
  }

  y = getY();
  fill(0,0,0,0);
  stroke(0,0,0,0);
  rect(x, y, snowWidth, snowHeight);
  image(rock, x, y, snowWidth, snowHeight);

  nextPosition();
}

void drawTarget(){
  targetX += targetSpeed * targetDirection;
  
  if (targetX > width - 60 || targetX < 10)
    targetDirection *= -1;
    
  rect(targetX, targetY, enderWidth, enderHeight); 
  image(target, targetX, targetY, enderWidth, enderHeight);
}

void drawEverything(){ 
  drawSnowball();
  drawTarget();
  drawUI();
}

void restartLaunch(){
  if(power > 0)
    x = 0;
  if(power == 0)
    y = 0;
  played = false;
  update = true;
  scored = false;
}

void gameOver(){
  fill(#F03A95);
  rect(height/2, width/2, 200, 90, 3);
  fill(#FFFFFF);
  text("Fin del juego", height/2 + 70, width/2 + 50);
  noLoop();
}

boolean hits(float x, float y, float snowWidth, float snowHeight, float targetX, float targetY, float enderWidth, float enderHeight){
               // Choque en x
               boolean hitX = x < targetX + enderWidth && x + snowWidth > targetX;
               
               // Choque en y
               boolean hitY = y < targetY + enderHeight - 5 && y + snowHeight > targetY + 10;
               
               // Si ambos se tocan en x e y, retorna true
               return hitX && hitY;
}

void draw(){
    image(wallpaper, 0, 0, width, height);
    if(frameCount % 30 == 0)
      seconds--; // subtract 1 from the timer
    drawEverything();
    if(hits(x, y, snowWidth, snowHeight, targetX, targetY, enderWidth, enderHeight)){
      if(scored == false){
          int choose = int(random(3));
          switch(choose){
            case 0:
              hit1.play();
              break;
            case 1:
              hit2.play();
              break;
            case 2:
              hit3.play();
              break;
          }
          score++;
          scored = true;
          delay(100);
      }
    }
      
    if(seconds == 0)
      gameOver();
}
