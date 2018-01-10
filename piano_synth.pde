int plat_h;
int plat_w;
int plat_x;
int plat_y;

int tank_h;
int tank_w; 
int tank_x;
int tank_y;

Note middle_c;
String[] notes_str;
String notefilename = "\\NoteFiles\\furelise.csv";
ArrayList<Note> notes;
Gun gun;

int minlength = 0;
int fadetime = 250000;

void setup() {
 size(1000, 700);
 colorMode(HSB);
 
 plat_h = height/20;
 plat_w = width/2;
 plat_x = width/2;
 plat_y = height/2;
 
 tank_h = height/30;
 tank_w = width/20;
 tank_x = width/2;
 tank_y = plat_y - plat_h/2 - tank_h/2;
 
 middle_c = new Note(255, 40, 10000000, 1000000, 5);
 
 notes = new ArrayList<Note>();
 notes_str = loadStrings(notefilename);
 for (int i = 0 ; i < notes_str.length; i++) {
   
   color c = color(0, 0, 0);
   String[] line = split(notes_str[i], ',');
   int pitch = int(line[0])-20;
   int volume = int(line[1]);
   int len = max(int(line[2]), minlength);
   int time = int(line[3]);
   Note note = new Note(c, pitch, len, time, volume);
   notes.add(note);
 }
 
 gun = new Gun(color(255), tank_x, tank_y, tank_w, tank_h);

}

void draw() {
  background(0);
  
  stroke(255);
  fill(255);
  rectMode(CENTER);
  rect(plat_x, plat_y, plat_w, plat_h);
  
  gun.display();
  
  //middle_c.display();
  for (int i = 0; i<notes.size(); i++){
    Note note = notes.get(i);
    note.display();
  }
  
}