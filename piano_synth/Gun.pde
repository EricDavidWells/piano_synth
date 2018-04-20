class Gun {
 
 color c;
 PVector pos;
 float g = 9.81;
 PImage img;
 float v = 0;
 
 Gun(color c_, float xpos, float ypos, PImage img_){
   c = c_;
   pos = new PVector(xpos, ypos);
   img = img_;
 }
 
 void display(){
  stroke(c);
  fill(c);
  image(img, pos.x-width/90, pos.y+width/90);
 }
}