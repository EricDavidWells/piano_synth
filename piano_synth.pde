
int tank_h;
int tank_w; 
int tank_x;
int tank_y;

Note middle_c;
String[] notes_str;
String notefilename = "\\NoteFiles\\porzgoret.csv";
ArrayList<Note> notes;
ArrayList<Bullet> bullets;
Gun gun;


int minlength = 0;
int fadetime = 250000;

void setup() {
 size(1000, 700);
 colorMode(HSB);
 rectMode(CENTER);  
 
 // create all tank shape parameters
 tank_h = height/30;
 tank_w = width/20;
 tank_x = width/8;
 tank_y = height*2/3;
 
 middle_c = new Note(255, 40, 10000000, 1000000, 5);
 
  gun = new Gun(color(255), tank_x, tank_y, tank_w, tank_h);
 
 bullets = new ArrayList<Bullet>();
 
 // load all notes into arraylist as objects
 notes = new ArrayList<Note>();
 notes_str = loadStrings(notefilename);
 for (int i = 0 ; i < notes_str.length; i++) {
   
   color c = color(0, 0, 0);  // set color to 0,0,0 to enable rainbow colors
   String[] line = split(notes_str[i], ',');  // take single line
   int pitch = int(line[0])-20;  // split line into components
   int volume = int(line[1]);
   int len = max(int(line[2]), minlength);
   int time = int(line[3])+5000000;
   Note note = new Note(c, pitch, len, time, volume);
   notes.add(note);
   
   Bullet bullet = new Bullet(c, note.pos.x, note.pos.y, width/100, (height*volume/127), gun.pos, time);
   bullets.add(bullet);
   
   
 }
 
 // create gun object


}

void draw() {
  background(0);
  
  gun.display();
  
  //middle_c.display();
  for (int i = 0; i<notes.size(); i++){
    Note note = notes.get(i);
    note.display();
    
    Bullet bullet = bullets.get(i);
    if (millis()*1000 > bullet.fire_time && millis()*1000 < bullet.hit_t){
      bullet.drive();
      bullet.display();
    }
  }
}