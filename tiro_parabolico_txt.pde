// parecido a tiro parabólico
// comenzar en 0,0
// terminar a la mitad del largo


void setup(){
  size(600, 400);
  background(#FFFFFF);
}

void draw(){
  int amplificacion = 50;
  float y;
  for(float x = 0; x < width; x += 0.1){
    // * 50 amplifica la función
 // y = sin(x) * amplificacion;
    y = cos(x) * amplificacion;
    // Dividirlo a la mitad moverá la función
    // Multiplicar x por constante apliará a lo largo
    point(x * 10, y + height/2);
    // Imprime a consola
    println(y);
  }
}
