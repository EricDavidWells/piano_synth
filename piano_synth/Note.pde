class Note {
 
 PVector pos;
 float h = width/88;  // height
 float w = width/88;  // width
 color c;    // color
 int p;    // pitch
 int l;    // length
 int t;    // time
 int v;    // volume
 
 Note(color c_, int p_, int l_, int t_, int v_){
   c = c_;
   p = p_;
   l = l_;
   t = t_;
   v = v_;
   pos = new PVector(width/88.0*p-width/(88.0*2), height-width/172.0);
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
     //noStroke();
     strokeWeight(1);
     stroke(100, 100, 100);
     fill(c, alpha);  
     //rect(pos.x, pos.y, w, h);
     rect(pos.x, pos.y, w, v/127.0*width/10.0*(alpha/255.0));
   }
 }

}