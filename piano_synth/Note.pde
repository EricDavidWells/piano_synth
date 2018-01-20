class Note {
 
 PVector pos;
 float h;  // height
 float w;  // width
 color c;    // color
 int p;    // pitch
 int l;    // length
 int t;    // time
 int v;    // volume
 
 Note(color c_, int p_, int l_, int t_, int v_, PVector pos_, int w_, int h_){
   c = c_;
   p = p_;
   l = l_;
   t = t_;
   v = v_;
   pos = pos_;
   h = h_;
   w = w_;
   
   // adjust color to rainbow based on position
   if (c == color(0, 0, 0)){
     c = color(p_*255/88, 255, 255);
   }
 }

 void display(){
   int time = millis()*1000;
   if (time>t && time<(t+l) && l != 0){
     float alpha = 255;
     if (time>t && time<(t+l)){
      alpha = 255;
     }
     else if (time>(t+l) && time<(t+l+fadetime)){
       alpha = (1.0-(time-(t+l))*1.00/fadetime)*255.00;
     }
    alpha = (1.0-(time-t)*1.0/l)*255.0;
     //strokeWeight(1);
     //stroke(100, 100, 100, alpha);
     noStroke();
     fill(c, alpha);  
     rect(pos.x, pos.y, w, max((v-minvolume)*1.0/(maxvolume-minvolume)*width/5.0*(alpha/255.0), int(h)));
   }
 }

}