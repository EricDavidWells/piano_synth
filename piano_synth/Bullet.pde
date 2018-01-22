class Bullet {
  color c;
  PVector pos;
  PVector vel;
  float g = 300;
  float r;
  int prev_time;
  int fire_time;
  int hit_t;
  Note note;
  
  Bullet(Note note_, float r_, float h, PVector gun_pos){
    
    note = note_;
    c = note.c;
    hit_t = note.t;
    pos = new PVector(gun_pos.x, gun_pos.y);
    r = r_;

    // catch if the desired height is lower than the gun
    if (h <= (height-gun_pos.y)){
      h = height - gun_pos.y;
    }
    
    // calculate the bullet fire time
    float v1 = sqrt(2*g*(h-(height-gun_pos.y)));  // initial y velocity to reach target height
    float v2 = sqrt(2*g*((h-(height-gun_pos.y))+(height-gun_pos.y)-(height-note.pos.y)));  // bullet hit velocity
    float t = (v1+v2)/g;  // flight time
    float bullet_dx = note.pos.x - gun_pos.x;  // x distance
    float vx = bullet_dx/t;  // initial x velocity
    
    vel = new PVector(vx, -v1);  // set velocity to the initial velocity
    fire_time = hit_t - int(t*1e6);  // calculate the time to fire the bullet
    prev_time = fire_time;  // pre allocate the previous time for driving function //<>//
 }
 
 void display(){
   int time = millis()*1000 - renderdelay;  // grab current time
   if (time > fire_time && time < hit_t){  // if time is in the bullet firing range
     int brightness = int(((time-fire_time)*1.0/(hit_t-fire_time)*2)*255);  // adjust brightness based on time
     float hue = hue(c);  // grab hue and saturation to adjust brightness when displaying
     float sat = saturation(c);
     stroke(hue, sat, brightness);
     fill(hue, sat, brightness); //<>//
     ellipse(pos.x, pos.y, r, r);
     drive(time);  // move bullet
   }
 }
 
 void drive(int time){
   vel.y += g*(time-prev_time)/1e6;  // adjust velocity
   pos.x += vel.x*(time-prev_time)/1e6;  // adjust position
   pos.y += vel.y*(time-prev_time)/1e6;  // adjust position
   prev_time = time;  // update previous time
 }
}