void setup(){
  size(400, 600);
}
void draw(){
  for(int x = 0; x < width; x++){
    point(x, x / 1.5);
  }
}
