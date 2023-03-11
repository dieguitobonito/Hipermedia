// /(width*PI)*longitud // longitud es una variable que va de 0 a 10 conforme a

// botonSumar(){
//  if(intensidad < 10)
//    intensidad++;
//  longitud = intensidad / 5; // relación para que muestre intensidad conforme a longitud
//




import processing.sound.*;
SoundFile song, bow, hit1, hit2, hit3;

// Variable para cargar img
PImage fondo;
PImage diamante;

void setup(){
  size(600, 400);
  // El archivo necesita dirección relativa
  fondo = loadImage("6.png");
  diamante = loadImage("diamond.png");
  frameRate(30);
  bow = new SoundFile(this, "bow.mp3");
  song = new SoundFile(this, "calm1.mp3");
  hit1 = new SoundFile(this, "hit1.mp3");
  hit2 = new SoundFile(this, "hit2.mp3");
  hit3 = new SoundFile(this, "hit3.mp3");

  song.loop();
}

// VARIABLES GLOBALES
float x = 0, y, acceleration = 1;
// Cuántas veces se tocaron los botones entre lanzamientos
int lessTimes = 0, moreTimes = 0;
// Al inicio se mostrará la parábola en una línea,
// esto determina que si se presiona algún botón, se elimine la
// línea
// Determina la anchura de seno
int opening = 20;

// Altura conforme a x
float calculateY(float x){
  float tmp = 0;
  tmp = sin(x/(opening)-PI/2)*height+height;
  return tmp;
}

void playHitSound(){
  float numerito = random(3);
  int escoge = int(numerito);
  switch(escoge){
    case 0:{
      hit1.play();
      break;
    }
    case 1:{
      hit2.play();
      break;
    }
    case 2:{
      hit3.play();
      break;
    }
  }
}

int level = 0;

void draw(){
  y = calculateY(x);
  image(fondo, 0, 0, width, height);
  image(diamante, x, y, 50, 50);
  drawButton(level);
    
    if(y >= height - 20 || x >= width - 30){
      if(x >= width - 30){
        playHitSound();
      }
      else{
        bow.play();
      }
      while(lessTimes >= 0){
        decAcceleration();
        lessTimes -= 1;
      }
      while(moreTimes >= 0){
        incAcceleration();
        moreTimes -= 1;
      }
      x = 0;
    }else{
      x += acceleration;
    }
}

void stopAll(){
  noLoop();
}

void mousePressed(){
  // Pausar
  if(mouseX > 500 && mouseX < 560 && mouseY > 10 && mouseY < 30){
    noLoop();
  }
  // Aumentar tiro
  if(mouseX > 535 && mouseX < 560 && mouseY > 40 && mouseY < 60){
    moreTimes += 1;
  }

  // Decrementar tiro
  if(mouseX > 500 && mouseX < 525 && mouseY > 40 && mouseY < 60){
    lessTimes += 1;
  }    
}

void drawButton(int level){
  // Botón pausa
  fill(#52D1BF);
  rect(500, 10, 60, 20, 3);
  fill(0, 255, 255);
  triangle(515, 12, 515, 28, 525, 20);
  
  // Botón menos
  fill(#52D1BF);
  rect(500, 40, 25, 20, 3);
  fill(0, 255, 255);
  rect(505, 47, 15, 5, 1);
  
  // Botón más
  fill(#52D1BF);
  rect(535, 40, 25, 20, 3);
  // - del +
  fill(0, 255, 255);
  rect(540, 47, 15, 5, 1);
  // | del +
  fill(0, 255, 255);
  rect(545, 42, 5, 15, 1);
  
  // Botón intensidad
  fill(#52D1BF);
  rect(500, 80, 60, 30, 3);
  fill(#000000);
  text(level, 525, 100);

}

void mouseReleased(){
  loop();
}

void incAcceleration(){
  if(opening < 750 && acceleration < 80){
    level += 1;
    opening += 20;
    acceleration += 1.5;
  }
}

void decAcceleration(){
  if(opening > 20 && acceleration > 0){
    level -= 1;
    opening -= 20;
    acceleration -= 1.5;
  }
}
