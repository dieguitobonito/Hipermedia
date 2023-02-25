void setup(){
    size(600, 400);
    background(#C0C6C6);
}
void draw(){
  int medida = 5;
  int medida2 = 595;
  int k = 0;
  int i = 0;
  int x = 5;
  int R = 100;
  int G =  200;
  int B = 100;
  
  do{
    R = (R <= 255) ? R + 10 : R - 120;
    stroke(R, G, B);
    for(k = i; k < width - medida; k++)
      point(k, medida);
      
    G = (G <= 255) ? G + 10 : G - 240;
    stroke(R, G, B);
    
    for(k = x; k < height - medida; k++)
      point(medida2, k);
    B = (R <= 200) ? B + 5 : B - 100;
    stroke(R, G, B);
    
    for(k = x; k < width - medida; k++)
      point(k, height - medida);
      stroke(R, G, B);
    
    R = (B <= 255) ? R - 5 : R - 500;
    stroke(R, G, B);
    for(k = i - 10; k < height - medida; k++)
      point(medida, k);
    
    i += 5;
    x += 5;
    medida += 5;
    medida2 += 5;
  }while(i <= height / 2);
}
