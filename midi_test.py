
import mido
from mido import MidiFile

# open a midi file
mid = MidiFile(r'C:\Users\bwcon\Documents\Processing Projects\piano_synth\MidiFiles\c-major-scale-on-treble-clef.mid')
print(mid.type)     # midi file type (0, 1, or 2)
print(mid.length)   # time length in seconds
print(mid.ticks_per_beat)   # ticks per beat, tick is the smallest time unit

# mido.get_output_names()   # gets available output port names

note_msgs = []
for i, track in enumerate(mid.tracks):
    # print('Track {}: {}'.format(i, track.name))
    for msg in track:
        if 'note' in msg.type:
            note_msgs.append(msg)
            # print(msg)

notes = []

# seperates note on and off signals into note volume, length, pitch, and time
for n, msg in enumerate(note_msgs):
    if msg.type == 'note_on':
        note_length = 0
        note_pitch = msg.note
        note_volume = msg.velocity
        for n_, msg_ in enumerate(note_msgs[n+1:], n+1):
            note_length += msg_.time
            if msg_.note == msg.note and msg_.type == 'note_off':
                break

        print(note_length)
        # notes.append([note_length, note_pitch, note_volume])


