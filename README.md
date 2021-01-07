My attempt at creating a colorful visualization of common .midi files

# Requirements
* Python 3.6
* mido 1.2.8
* Processing 3.5.4

# Usage

* Place midi file in the data folder.
* Open up `midi_converter.py`, 
** change the `midifilename` variable to match the .midi file
** change the `outputfilename` variable to match the song title
** run the script
* Open the processing script `piano_synth`
** Change the `midifilename` variable to match the .midi file
** Change the `notefilename` variable to match the newly created .csv file from the python script
** Run the program

# Notes
Not all .midi files work, tracks with multiple instruments and older files tend to fail

# Video Link
The end result should look like [https://www.youtube.com/watch?v=FQs-HAAVmhs](this).
