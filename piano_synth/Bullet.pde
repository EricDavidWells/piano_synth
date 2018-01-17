class Bullet {
  color c;
  PVector pos;
  PVector vel;
  float g = 300;
  float r;
  int prev_time;
  int fire_time;
  int hit_t;
  
  Bullet(color c_, float target_posx, float target_posy, float r_, float h, PVector gun_pos, int hit_t_){
    
    c = c_;
    if (c == color(0, 0, 0)){
     c = color(target_posx/width*255, 255, 255);
    }
    pos = new PVector(gun_pos.x, gun_pos.y);
    r = r_;

    // catch if the desired height is lower than the gun
    if (h <= (height-gun_pos.y)){
      h = height - gun_pos.y;
    }
    
    hit_t = hit_t_;
    
    float v1 = sqrt(2*g*(h-(height-gun_pos.y)));
    float v2 = sqrt(2*g*((h-(height-gun_pos.y))+(height-gun_pos.y)-(height-target_posy)));
    float t = (v1+v2)/g;
    float bullet_dx = target_posx - gun_pos.x;
    float vx = bullet_dx/t;
    
    vel = new PVector(vx, -v1);
    
    fire_time = hit_t - int(t*1e6);
    prev_time = fire_time; //<>// //<>//
 }
 
 void display(){
   int brightness = int(((millis()*1000-fire_time)*1.0/(hit_t-fire_time)*2)*255);
   float hue = hue(c);
   float sat = saturation(c);
   stroke(hue, sat, brightness);
   fill(hue, sat, brightness); //<>//
   ellipse(pos.x, pos.y, r, r);
 }
 
 void drive(){
   int time = millis()*1000;
   vel.y += g*(time-prev_time)/1e6;
   pos.x += vel.x*(time-prev_time)/1e6;
   pos.y += vel.y*(time-prev_time)/1e6;
   
   prev_time = time;
 }
}