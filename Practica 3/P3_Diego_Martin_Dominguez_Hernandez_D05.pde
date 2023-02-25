void setup(){
 size(500, 350);
 background(#000000);
 stroke(#00ff00);
 frameRate(999999999);
}

float x=0, y, inc_x=0.08;

void draw(){
  y=sin(x/(width/PI)  -  PI/2)*height+height;
  point(x,y);
  x+=inc_x;
}

void mousePressed(){ //mouseClicked
  noLoop();
  println(mouseX+", "+mouseY);
}

void mouseReleased(){
 loop();
}
