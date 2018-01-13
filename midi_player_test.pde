import javax.sound.midi.*;
import java.io.*;
 
Sequencer playMidi;
File selection;
 
void setup()
{
  size(200, 200);
 
  try
  {
    File selection = new File("Porz-Goret-Yann-Tiersen.mid");
    playMidi = MidiSystem.getSequencer();
    playMidi.open();
    Sequence fileSequence = MidiSystem.getSequence(selection);
    playMidi.setSequence(fileSequence);
    playMidi.start();
  }catch(Exception e)
  {
    println("FILE NOT FOUND!!");
  }
}
 
/*void draw()
{ 
}*/