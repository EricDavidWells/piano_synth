import javax.sound.midi.*;  // packages for playing midi files
import java.io.*;
Sequencer midiplayer;
File midifile;
Sequence fileSequence;
boolean midiplayerflag = false;
boolean midistartflag = false;

PImage bg;
String bgfilename = "\\Pictures\\cloud_1.jpg";
PImage gun_pic;
String gunfilename = "\\Pictures\\rainbow_circle_3.png";

int gun_h;
int gun_w; 
int gun_x;
int gun_y;

Note middle_c;
String[] notes_str;
//String notefilename = "\\NoteFiles\\fur_elise.csv";
//String midifilename = "\\MidiFiles\\fur_elise.mid";
//String notefilename = "\\NoteFiles\\porz_goret.csv";
//String midifilename = "\\MidiFiles\\porz_goret.mid";
String notefilename = "\\NoteFiles\\mozart_2pianos_1.csv";
String midifilename = "\\MidiFiles\\mozart_2pianos_1.mid";
ArrayList<Note> notes;
ArrayList<Bullet> bullets;
Gun gun;

int minlength = 250000;
int fadetime = 50000;
int introtime = 8000000;
int soundoffset = 450000;

int maxvolume = 0;
int minvolume = 127;
int maxkey = 0;
int minkey = 88;

void setup() {
  
 size(1000, 600);
 colorMode(HSB);
 imageMode(CENTER);
 rectMode(CENTER);  // change rectangle display mode for coordinates to be at center
 
 // load background image and resize to fit screen
 bg = loadImage(dataPath("") + bgfilename);
 bg.resize(width, height);
 
 // load gun image and resize
 gun_pic = loadImage(dataPath("") + gunfilename);
 gun_pic.resize(width/40, width/40);
 
 // create all gun shape parameters
 gun_h = height/30;
 gun_w = width/20;
 gun_x = width/2;
 gun_y = height/2;
 gun = new Gun(color(255), gun_x, gun_y, gun_w, gun_h, gun_pic);  // create gun object
 
 bullets = new ArrayList<Bullet>();
 notes = new ArrayList<Note>();
 
 notes_str = loadStrings(dataPath("") + notefilename);  // load all lines of the data file
 
 for (int i = 0 ; i < notes_str.length; i++) {
   
   // obtain information from song
   String[] line = split(notes_str[i], ',');
   int pitch = int(line[0])-20;  // minus 20 to move midi (0-127) pitch to piano pitch (0-88)
   int volume = int(line[1]);  // volume on scale from (0-127)
   maxvolume = max(maxvolume, volume);
   minvolume = min(minvolume, volume);
   maxkey = max(maxkey, pitch);
   minkey = min(minkey, pitch);
 }

 // create note object from each line and gather information about song
 for (int i = 0 ; i < notes_str.length; i++) {
   color c = color(0, 0, 0);  // set color to 0,0,0 to enable rainbow colors
   String[] line = split(notes_str[i], ',');
   int pitch = int(line[0])-20;  // minus 20 to move midi (0-127) pitch to piano pitch (0-88)
   int volume = int(line[1]);  // volume on scale from (0-127)
   int len = max(int(line[2]), minlength);  // note sustain time in microseconds
   int time = int(line[3])+introtime;  // note start time in microseconds
   PVector position = new PVector(width*1.0/(maxkey-minkey+10)*(pitch-minkey+5), height-width/172.0);  // spread out position to cover majority of screen
   int h = width/(maxkey-minkey);
   int w = width/(maxkey-minkey);
   Note note = new Note(c, pitch, len, time, volume, position, w, h);
   notes.add(note);
 }
 // make a bullet for each note
 for (int i = 0; i<notes.size(); i++){ //<>//
   Note note = notes.get(i);
   int bullet_r = width/100;
   float bullet_h = (height*1.0*(note.v-minvolume)*1.0/(maxvolume-minvolume));
   Bullet bullet = new Bullet(note, bullet_r, bullet_h, gun.pos);
   bullets.add(bullet);
 }
}

void draw() { 
  // start the midi file at what is hopefully the right time
  if (midiplayerflag == false){
    midiplayerflag = true;
    try {
    File selection = new File(dataPath("") + midifilename);
    midiplayer = MidiSystem.getSequencer();
    midiplayer.open();
    fileSequence = MidiSystem.getSequence(selection);
    midiplayer.setSequence(fileSequence);
  }
  catch(Exception e) {
    println("FILE NOT FOUND!!");
  }
  }
  if (midistartflag == false && millis()*1000 > introtime - soundoffset){
    midistartflag = true;
    midiplayer.start();
  }
  
  background(bg);
  gun.display();
  
  // display every note and every bullet
  for (int i = 0; i<notes.size(); i++){
    Note note = notes.get(i);
    note.display();
    Bullet bullet = bullets.get(i);
    bullet.display();
  }
}

long micros(){
  return System.nanoTime()/1000;
}