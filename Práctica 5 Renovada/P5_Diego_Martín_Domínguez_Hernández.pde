// Variables para cargar imágenes
PImage wallpaper;
PImage rock;

// Librería de sonido
import processing.sound.*;
SoundFile song;
SoundFile bow;


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

void setup(){
  size(600, 400);
  // El archivo necesita dirección relativa
  wallpaper = loadImage("6.png");
  rock = loadImage("diamond.png");
  frameRate(30);
  
  bow = new SoundFile(this, "bow.mp3");
  
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
  rect(500, 80, 60, 30, 3);
  fill(#000000);
  text(level, 525, 100);
}

void nextPosition(){
  if(power > 0)
    x += incX;
  if(power == 0)
    y += incY;
}

boolean played = false;
void drawEverything(){ 
  if(update == true)
    power = intensities * level;
    
  distance = sqrt(height * height + (power/2) * (power/2));
  incX = distance * 0.015;

  image(wallpaper, 0, 0, width, height);
  if(played == false){
      bow.play();
      played = true;
  }

  image(rock, x, getY(), 50, 50);
  nextPosition();
    
  drawUI();
}

void restartLaunch(){
  if(power > 0)
    x = 0;
  if(power == 0)
    y = 0;
  played = false;
  update = true;
}

void draw(){
    drawEverything();
}
