class Gun {
 
 color c;
 PVector pos;
 float w;
 float h;
 float g = 9.81;
 PImage img;
 
 Gun(color c_, float xpos, float ypos, float w_, float h_, PImage img_){
   c = c_;
   pos = new PVector(xpos, ypos);
   w = w_;
   h = h_;
   img = img_;
 }
 
 void display(){
  stroke(c);
  fill(c);
  //rect(pos.x, pos.y, w, h);
  imageMode(CENTER);
  image(img, pos.x, pos.y);
 }
}