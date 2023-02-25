void setup(){
  size(600, 401);
  background(#8AF5BD);
  noLoop();
}

void draw(){
  float a = width;
  float b = height; 
  float hypotenuse = sqrt(a * a + b * b);
  float xSpacing = width / hypotenuse;
  float ySpacing = height / hypotenuse;
  
  println(a);
  println(b);
  println(hypotenuse);
  println(xSpacing);
  println(ySpacing);
  float x = 0;
  float y = 0;
  for(float i = 0; i < width + height; i++){
    point(x, y);
    x += xSpacing;
    y += ySpacing;
    println("Valor de x ");
    println(x);
    println("Valor de y ");
    println(y);
  }

}
