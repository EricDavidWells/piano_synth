import javax.sound.midi.*;
import java.io.*;
Sequencer midiplayer;
File midifile;
Sequence fileSequence;
boolean midiplayerflag = false;
boolean midistartflag = false;

PImage bg;
String bgfilename = "\\Pictures\\cloud_1.jpg";

int tank_h;
int tank_w; 
int tank_x;
int tank_y;

Note middle_c;
String[] notes_str;
String notefilename = "\\NoteFiles\\mozart_2pianos_1.csv";
String midifilename = "\\MidiFiles\\mozart_2pianos_1.mid";
ArrayList<Note> notes;
ArrayList<Bullet> bullets;
Gun gun;

int minlength = 0;
int fadetime = 125000;
int introtime = 5000000;
int soundoffset = 250000;

int maxvolume = 0;
int minvolume = 0;

void setup() {
  
 size(1600, 900);
 colorMode(HSB);
 rectMode(CENTER);  
 bg = loadImage(dataPath("") + bgfilename);
 image(bg, 0, 0);
 bg.resize(width, height);
 //try {
 //   File selection = new File(dataPath("") + midifilename);
 //   midiplayer = MidiSystem.getSequencer();
 //   midiplayer.open();
 //   fileSequence = MidiSystem.getSequence(selection);
 //   midiplayer.setSequence(fileSequence);
 //   midiplayer.start();
 // }
 // catch(Exception e) {
 //   println("FILE NOT FOUND!!");
 // }
 
 // create all tank shape parameters
 tank_h = height/30;
 tank_w = width/20;
 tank_x = width/2;
 tank_y = height*3/4;
 
 middle_c = new Note(255, 40, 10000000, 1000000, 5);
 
 gun = new Gun(color(255), tank_x, tank_y, tank_w, tank_h);
 
 bullets = new ArrayList<Bullet>();
 
 // load all notes into arraylist as objects
 notes = new ArrayList<Note>();
 notes_str = loadStrings(dataPath("") + notefilename);
 for (int i = 0 ; i < notes_str.length; i++) {
   
   color c = color(0, 0, 0);  // set color to 0,0,0 to enable rainbow colors
   String[] line = split(notes_str[i], ',');  // take single line
   int pitch = int(line[0])-20;  // split line into components
   int volume = int(line[1]);
   int len = max(int(line[2]), minlength);
   int time = int(line[3])+introtime;
   Note note = new Note(c, pitch, len, time, volume);
   notes.add(note);
   
   //Bullet bullet = new Bullet(c, note.pos.x, note.pos.y, width/100, (height*volume/127), gun.pos, time);
   //bullets.add(bullet);
   
   maxvolume = max(maxvolume, volume);
   minvolume = min(minvolume, volume);
 }
  
 for (int i = 0; i<notes.size(); i++){
   Note note = notes.get(i);
   Bullet bullet = new Bullet(note.c, note.pos.x, note.pos.y, width/100, (height*(note.v-minvolume)/(maxvolume-minvolume)), gun.pos, note.t);
   bullets.add(bullet);
 }

}

void draw() {
  background(bg);
  
  if (midiplayerflag == false){
    midiplayerflag = true;
    try {
    File selection = new File(dataPath("") + midifilename);
    midiplayer = MidiSystem.getSequencer();
    midiplayer.open();
    fileSequence = MidiSystem.getSequence(selection);
    midiplayer.setSequence(fileSequence);
    println("working");
  }
  catch(Exception e) {
    println("FILE NOT FOUND!!");
  }
  }
  if (midistartflag == false && millis()*1000 > introtime - soundoffset){
    midistartflag = true;
    midiplayer.start();
  }
  
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

long micros(){
  return System.nanoTime()/1000;
}