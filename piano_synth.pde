int plat_h;
int plat_w;
int plat_x;
int plat_y;

int tank_h;
int tank_w; 
int tank_x;
int tank_y;

Note middle_c;

void setup() {
 size(1000, 700);
 
 plat_h = height/20;
 plat_w = width/2;
 plat_x = width/2;
 plat_y = height/2;
 
 tank_h = height/30;
 tank_w = width/20;
 tank_x = width/2;
 tank_y = plat_y - plat_h/2 - tank_h/2;
 
 middle_c = new Note(255, 44, 1, 2, 5);
 
}

void draw() {
  background(0);
  
  stroke(255);
  fill(255);
  rectMode(CENTER);
  rect(plat_x, plat_y, plat_w, plat_h);
  stroke(0, 255, 0);
  fill(0, 255, 0);
  rect(tank_x, tank_y, tank_w, tank_h);
  
  middle_c.display();
  
}

class Note {
 
 color c;    // color
 int p;    // pitch
 int l;    // length
 float t;    // time
 int v;    // volume
 
 Note(color c_, int p_, int l_, float t_, int v_){
   c = c_;
   p = p_;
   l = l_;
   t = t_;
   v = v_;
 }

 void display(){
   int time = millis();
   if (time>t*1000 && time<(t+l)*1000){
     int alpha = min((time-int(t*1000))*255/500, 255);  // fading function
     alpha = min(alpha, min((int((t+l)*1000)-time)*255/500, 255));
     stroke(c, alpha);
     fill(c, alpha);
     rect(width/88*p, height-width/172, width/44, width/44);
   }
 }

}