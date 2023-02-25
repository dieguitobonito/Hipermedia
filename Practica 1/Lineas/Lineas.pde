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
  int R = 0;
  int G =  0;
  int B = 150;
  
  do{
    R = (R <= 255) ? R + 10 : R - 200;
    stroke(R, G, B);
    for(k = i; k < width - medida; k++)
      point(k, medida);
      
    G = (G <= 255) ? G + 10 : G - 200;
    stroke(R, G, B);
    
    for(k = x; k < height - medida; k++)
      point(medida2, k);
    B = (R <= 200) ? B + 5 : B - 200;
    stroke(R, G, B);
    
    for(k = x; k < width - medida; k++)
      point(k, height - medida);
      stroke(R, G, B);
    
    R = (B <= 255) ? R - 5 : R - 200;
    stroke(R, G, B);
    for(k = i - 10; k < height - medida; k++)
      point(medida, k);
    
    i += 5;
    x += 5;
    medida += 5;
    medida2 += 5;
  }while(i <= 200);
}
