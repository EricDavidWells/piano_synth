class Key {
 
 PVector pos;
 float h = 0;  // height
 float w;  // width
 color c;    // color
 float increment;
 int p;
 int alpha = 100;
 
 Key(color c_, PVector pos_, int w_, float increment_, int p_){
   
   c = c_;
   pos = pos_;
   w = w_;
   increment = increment_;
   p = p_;
   
   // adjust color to rainbow based on position
   if (c == color(0, 0, 0)){
     c = color(p*255/(maxkey-minkey), 255, 255);
   }
   

 }

 void display(){
   noFill();
   stroke(c, alpha);
   rect(pos.x, pos.y, w, h);
 }
 
 void play(){
   h += increment;
 }

}