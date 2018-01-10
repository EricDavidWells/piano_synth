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
 
 middle_c = new Note(255, 40, 10000000, 1000000, 5);
 
 notes = new ArrayList<Note>();
 notes_str = loadStrings(notefilename);
 for (int i = 0 ; i < notes_str.length; i++) {
   
   String[] line = split(notes_str[i], ',');
   int pitch = int(line[0])-20;
   int volume = int(line[1]);
   int len = int(line[2]);
   int time = int(line[3]);
   Note note = new Note(255, pitch, len, time, volume);
   notes.add(note);
 }

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
  for (int i = 0; i<notes.size(); i++){
    Note note = notes.get(i);
    note.display();
  }
  
}

class Note {
 
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
 }

 void display(){
   int time = millis()*1000;
   if (time>t && time<(t+l)){
     //int alpha = min((time-t)*255/500000, 255);  // fading function
     //alpha = min(alpha, min(((t+l)-time)*255/500000, 255));
     int alpha;
     if (time>t && time<(t+l/2)){
      alpha = min((time-t)*255/1, 255);  // fading function
     }
     else{
       alpha = min(((t+l)-time)*255/1, 255);
     }
     
     stroke(c, alpha);
     fill(c, alpha);
     rect(width/88.0*p-width/(88.0*2), height-width/172.0, width/88.0, width/88.0);
   }
 }

}