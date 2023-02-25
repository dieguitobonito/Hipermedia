void setup(){
  size(600, 400);
  background(#000000);
  // Forma de aumentar la animación
  frameRate(999999);
}

// Dibujar una parábola que caiga a la mitad del lienzo, ajustable al lienzo

float x = 0, y;
int amplitud = 100;
int anchura = 30;
float inc_x = 0.1;
float tmp;

void draw(){
  // draw es un ciclo en sí mismo
  y = sin(x / anchura) * amplitud;

  x += inc_x;
  // point(x, y + height / 2);
  

  // Imprimir la parte derecha de ida
  if(y < 0 && tmp <= y){
    stroke(#FFFFFF);
    point(x, y + height /2);
  }
  //else{
  //  stroke(#00FF00);
  //  point(x, y + height /2);
  //}


  
  if(x >= width || x <= 0){
    inc_x *= -1;
    background(#000000);
  }
  tmp = y;
  
  // Posición del mouse
//  println(mouseX + ", " + mouseY);
}

// Interactuar con el mouse
//void mouseClicked(){
  // Detendrá la animación, mas no la reanudará
//  noLoop();
//}

//void mouseReleased(){
//  loop();
//}

// Ejecutado en el instante del click
//void mousePressed(){
//  noLoop();

//}
